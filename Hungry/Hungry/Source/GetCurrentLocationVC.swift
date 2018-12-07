
import UIKit
import SwiftLocation
import GooglePlaces
import GooglePlacePicker
import GoogleMaps


protocol LocationDelegate {
    func didLocationFound(_ controller: GetCurrentLocationVC, cityName: String)
}

class GetCurrentLocationVC: UIViewController {

    @IBOutlet weak var btnGetLocation: UIButton!
    
    var delegate :LocationDelegate! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnGetLocation.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        getCurrentCityName()
    }
    
    private func getCurrentCityName() {
        
        // request authorization
        Locator.requestAuthorizationIfNeeded()
        
        let mySharedObj = MySharedPreference()
        
        // Current Location
        let obj = Locator.currentPosition(accuracy: .city, onSuccess: { (location) -> (Void) in
            
            mySharedObj.setTempLatitude(location.coordinate.latitude)
            mySharedObj.setTempLongitude(location.coordinate.longitude)
            
            if CheckInternet.isConnected() == true {
                
                // convert lat, lng to city
                Locator.location(fromCoordinates: location.coordinate, onSuccess: { (place) -> (Void) in
                    
                    if place.count > 0 {
                        print("Address===1", place.last?.city)
                        guard let cityName = place.last!.city else {
                            return
                        }
                    // City find out successfully
                        self.delegate.didLocationFound(self, cityName: cityName)
                        
                    }
                }, onFail: { (error) -> (Void) in
                    // search from google
                    self.searchManually()
                })
            }
            
            
        }) { (error, last) -> (Void) in
            
            // Location Permission not set
            self.showAlertView("locTitle".localized, message: "locMessage".localized, btnTitle1: "btnCancel".localized, btnTitle2: "btnSetting".localized)
        }
    }
    
    // Permission PopUp
    private func showAlertView(_ title: String, message: String, btnTitle1: String, btnTitle2: String) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: btnTitle1, style: .default, handler: { (action: UIAlertAction!) in
            self.searchManually()
        }))
        refreshAlert.addAction(UIAlertAction(title: btnTitle2, style: .default, handler: { (action: UIAlertAction!) in
//            "App-Prefs:root=LOCATION_SERVICES"
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func automaticallyButtonClick(_ sender: UIButton) {
        getCurrentCityName()
    }
    
    private func searchManually() {
        let autocompleteController = GMSAutocompleteViewController()
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = convertToNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.blue])
        autocompleteController.primaryTextHighlightColor = UIColor.black
        autocompleteController.primaryTextColor = CustomColor.grayLight()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
    }
    
}

// implement  Google Places API
extension GetCurrentLocationVC: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let mySharedObj = MySharedPreference()
        
        mySharedObj.setTempLatitude(place.coordinate.latitude)
        mySharedObj.setTempLongitude(place.coordinate.longitude)
        
        mySharedObj.setCityName(place.name)
        
        print("Address===1", place.name)
        dismiss(animated: true, completion: nil)
        self.delegate.didLocationFound(self, cityName: place.name)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
        btnGetLocation.isHidden = false
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
        btnGetLocation.isHidden = false
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.Key: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
