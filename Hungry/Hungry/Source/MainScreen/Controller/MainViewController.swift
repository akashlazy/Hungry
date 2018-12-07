
import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loading: UIActivityIndicatorView!

    let HorizontalCellIdentifier = "HorizontalCell"
    let RestaurantCellIdentifier = "RestaurantCell"
    
    var arrRestObj = [ArrRestaurants]()
    var arrFilter = [ArrRestaurants]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.moveToDecideAppCondition()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblView.delegate = self
        tblView.dataSource = self
        
        searchBar.delegate = self
        
        viewConfiguration()
        
        let appPref = MySharedPreference()
        
        if appPref.getCityName() != "" {
            self.title = appPref.getCityName()
            
            if CheckInternet.isConnected() {
                showLoading()
            }
        }
    }
    
    private func viewConfiguration() {
        tblView.backgroundColor = CustomColor.lightBackground()
        
//        tblView.tableHeaderView = UIView()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "strSearch".localized
    }
    
    private func showLoading() {
        tblView.isHidden = true
        loading.startAnimating()
        loading.hidesWhenStopped = true
        ConnRequestManager().getRequest(Constant.MethodCommon.methodGeocode, classRef: self)
    }
    private func hideLoading() {
        tblView.isHidden = false
        loading.stopAnimating()
    }
    
    func refreshData() {
        hideLoading()
        arrRestObj = ArrRestaurants.sharedInstance.getRestaurants()
        arrFilter = arrRestObj
        tblView.reloadData()
    }
    
    func moveToDecideAppCondition() {
        let appPref = MySharedPreference()
        
        if appPref.getCityName() == "" || appPref.getTempLatitude() == 0.0 {
            let getLocation = GetCurrentLocationVC.init(nibName: "GetCurrentLocationVC", bundle: nil)
            getLocation.delegate = self
            
            self.present(getLocation, animated: true, completion: nil)
        }
    }
    
    // Implement Delegate & Datasource for UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Initialize Restaurent Cell
        var cell: RestaurantCell! = tableView.dequeueReusableCell(withIdentifier: RestaurantCellIdentifier) as? RestaurantCell
        
        if cell == nil {
            tblView.register(UINib(nibName: RestaurantCellIdentifier, bundle: nil), forCellReuseIdentifier: RestaurantCellIdentifier)
            cell = tableView.dequeueReusableCell(withIdentifier: RestaurantCellIdentifier) as? RestaurantCell
        }
        cell.configureRestaurantCell(arrFilter, index: indexPath.row)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rest = arrFilter[indexPath.row]
        
        // Move to Detail Information about Restaurant
        let detailViewObj = UIStoryboard.init(name: "DetailScreenVC", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailScreenVC") as? DetailScreenVC
        
        detailViewObj!.resID = rest.resID
        detailViewObj!.imageUrl = rest.thumb
        detailViewObj!.name = rest.name
        detailViewObj!.cuisines = rest.cuisines
        
        self.navigationController?.pushViewController(detailViewObj!, animated: true)
    }

}

// Getting Current Location and Search Near by Restaurants
extension MainViewController: LocationDelegate {
    func didLocationFound(_ controller: GetCurrentLocationVC, cityName: String) {
        if cityName.isEmpty {
            moveToDecideAppCondition()
        } else {
            let appPref = MySharedPreference()
            appPref.setCityName(cityName)
            self.dismiss(animated: true, completion: nil)
            
            self.title = cityName
            if CheckInternet.isConnected() {
                showLoading()
            }
        }
    }
}


// implement Search Operation
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty else {
            arrFilter = arrRestObj
            tblView.reloadData()
            return
        }
        
        arrFilter = arrRestObj.filter { (restaurant) -> Bool in
            return restaurant.name.lowercased().contains(searchText.lowercased())
        }
        tblView.reloadData()
    }
}
