
import UIKit
import GoogleMaps
import GooglePlaces
import GooglePlacePicker
import MapKit

class AddressCell: UITableViewCell, GMSMapViewDelegate {
    
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var googleMap: GMSMapView!
    @IBOutlet weak var satelliteBtn: UIButton!
    @IBOutlet weak var openBtn: UIButton!
    
    var toggle: Bool = false
    
    var coordinate: CLLocationCoordinate2D! = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let mySharedPref = MySharedPreference()
        
        googleMap.delegate = self
        
        satelliteBtn.contentEdgeInsets = UIEdgeInsets.init(top: 8,left: 8,bottom: 8,right: 8)
        satelliteBtn.backgroundColor = UIColor.white
        satelliteBtn.setTitle("Map".localized, for: .normal)
        satelliteBtn.setTitleColor(CustomColor.textBlackColor(), for: .normal)
        satelliteBtn.sizeToFit()
        
        googleMap.translatesAutoresizingMaskIntoConstraints = false
        googleMap.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        googleMap!.mapType = .hybrid
        
        googleMap.bringSubviewToFront(satelliteBtn)
        googleMap.bringSubviewToFront(openBtn)
    }
    
    @IBAction func satelliteButtonClick(_ sender: UIButton) {
        if !toggle {
            toggle = true
            googleMap.mapType = .satellite
            satelliteBtn.setTitle("Map".localized, for: UIControl.State())
            satelliteBtn.sizeToFit()
        } else {
            toggle = false
            googleMap.mapType = .normal
            satelliteBtn.setTitle("Sattelite".localized, for: UIControl.State())
            satelliteBtn.sizeToFit()
        }
    }
    
    @IBAction func openButtonClick(_ sender: UIButton) {
        openGoogleMap(coordinate)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ address: String) {
//        lblAddress.text = address
        
        let appPrefs = MySharedPreference()
        
        coordinate = CLLocationCoordinate2D(latitude: appPrefs.getLatitude(), longitude: appPrefs.getLongitude())
        
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withTarget: coordinate, zoom: 15)
        
        googleMap.camera = camera
        googleMap.settings.myLocationButton = false
        
        let marker = GMSMarker(position: coordinate)
        marker.map = self.googleMap
    }
    
    private func openGoogleMap(_ place: CLLocationCoordinate2D) {
        
        if let url = URL(string: "comgooglemaps://?saddr=&daddr=\(place.latitude),\(place.longitude)&directionsmode=driving") {
            UIApplication.shared.open(url, options: [:])
        } else {
            NSLog("Can't use comgooglemaps://");
        }
    }
    
    func mapView(mapView: GMSMapView, didTapMarker marker: GMSMarker) -> Bool {
        if marker.title != nil {
            
            let mapViewHeight = mapView.frame.size.height
            let mapViewWidth = mapView.frame.size.width
            
            
            let container = UIView()
            container.frame = CGRect(x: mapViewWidth - 100, y: mapViewHeight - 63, width: 65, height: 35)
            container.backgroundColor = UIColor.white
            self.addSubview(container)
            
            let googleMapsButton = CustomButton()
            googleMapsButton.setTitle("", for: .normal)
            googleMapsButton.setImage(UIImage(named: "googlemaps"), for: .normal)
            googleMapsButton.setTitleColor(UIColor.blue, for: .normal)
            googleMapsButton.frame = CGRect(x: mapViewWidth - 80, y: mapViewHeight - 70, width: 50, height: 50)
            googleMapsButton.addTarget(self, action: #selector(markerClick), for: .touchUpInside)
            googleMapsButton.gps = String(marker.position.latitude) + "," + String(marker.position.longitude)
            googleMapsButton.titleLabel?.text = marker.title
            googleMapsButton.tag = 0
            
            let directionsButton = CustomButton()
            
            directionsButton.setTitle("", for: .normal)
            directionsButton.setImage(UIImage(named: "googlemapsdirection"), for: .normal)
            directionsButton.setTitleColor(UIColor.blue, for: .normal)
            directionsButton.frame = CGRect(x: mapViewWidth - 110, y: mapViewHeight - 70, width:  50, height: 50)
            directionsButton.addTarget(self, action: #selector(markerClick), for: .touchUpInside)
            directionsButton.gps = String(marker.position.latitude) + "," + String(marker.position.longitude)
            directionsButton.titleLabel?.text = marker.title
            directionsButton.tag = 1
            self.addSubview(googleMapsButton)
            self.addSubview(directionsButton)
        }
        return true
    }
    
    @objc func markerClick(sender: CustomButton) {
        let fullGPS = sender.gps
        let fullGPSArr = fullGPS.characters.split{$0 == ","}.map(String.init)
        
        let lat1 : NSString = fullGPSArr[0] as NSString
        let lng1 : NSString = fullGPSArr[1] as NSString
        
        
        let latitude:CLLocationDegrees =  lat1.doubleValue
        let longitude:CLLocationDegrees =  lng1.doubleValue
        
        if (UIApplication.shared.openURL(NSURL(string:"comgooglemaps://")! as URL)) {
            if (sender.tag == 1) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?saddr=&daddr=\(latitude),\(longitude)&directionsmode=driving")! as URL)
            } else if (sender.tag == 0) {
                UIApplication.shared.openURL(NSURL(string:
                    "comgooglemaps://?center=\(latitude),\(longitude)&zoom=14&views=traffic")! as URL)
            }
            
        } else {
            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
            let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            var options = NSObject()
            if (sender.tag == 1) {
                options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span),
                    MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving
                    ] as NSObject
            } else if (sender.tag == 0) {
                options = [
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                    MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
                    ] as NSObject
            }
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = sender.titleLabel?.text
            mapItem.openInMaps(launchOptions: options as? [String : AnyObject])
        }
    }
}

class CustomButton: UIButton {
    var gps = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //TODO: Code for our button
    }
}
