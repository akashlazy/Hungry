
import UIKit
import Kingfisher
import RKParallaxEffect

class DetailScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    
    var parallaxEffect: RKParallaxEffect!
    
    var resID = ""
    var imageUrl = ""
    var name = ""
    var cuisines = ""
    
    let AddressCellIdentifier = "AddressCell"
    let OpeningHourCellIdentifier = "OpeningHourCell"
    let OpeningHourCellIdentifier1 = "OpeningHourCell1"
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        parallaxEffect = RKParallaxEffect(tableView: detailTableView)
        parallaxEffect.isParallaxEffectEnabled = true
        parallaxEffect.isFullScreenTapGestureRecognizerEnabled = true
        parallaxEffect.isFullScreenPanGestureRecognizerEnabled = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        
        detailTableView.delegate = self
        detailTableView.dataSource = self

        viewConfiguration()
        
        let appPref = MySharedPreference()
        appPref.setRestaurantID(resID)
        
        ConnRequestManager().getRequest(Constant.Restaurant.methodRestaurant, classRef: self)
 
    }
    
    func viewConfiguration() {
        
        
        let url = URL(string: imageUrl)
        
        imageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(1))], progressBlock: { receivedSize, totalSize in
            print("\(receivedSize)/\(totalSize)")
        }, completionHandler: { image, error, cacheType, imageURL in
            //            self.imageName = image
            
            if error != nil {
                //                self.imageName = UIImage(named: "ic_person_light_gray_24dp.png")
                //                self.profileImageButton.setImage(self.imageName, for: .normal)
            }
        })
    }
    
    func refreshData() {
        detailTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return LocationDetailInfo.sharedInstance.header[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            var cell: OpeningHourCell! = tableView.dequeueReusableCell(withIdentifier: OpeningHourCellIdentifier) as? OpeningHourCell
            
            if cell == nil {
                detailTableView.register(UINib(nibName: OpeningHourCellIdentifier, bundle: nil), forCellReuseIdentifier: OpeningHourCellIdentifier)
                cell = tableView.dequeueReusableCell(withIdentifier: OpeningHourCellIdentifier) as? OpeningHourCell
            }
            
            cell.lblTitle.text = cuisines
            cell.lblTitle.textColor = UIColor.red
            
            return cell
        } else if indexPath.section == 1 {
            var cell: OpeningHourCell! = tableView.dequeueReusableCell(withIdentifier: OpeningHourCellIdentifier1) as? OpeningHourCell
            
            if cell == nil {
                detailTableView.register(UINib(nibName: OpeningHourCellIdentifier1, bundle: nil), forCellReuseIdentifier: OpeningHourCellIdentifier1)
                cell = tableView.dequeueReusableCell(withIdentifier: OpeningHourCellIdentifier1) as? OpeningHourCell
            }
            
            cell.lblTitle.text = "View All"
            cell.lblTitle.textColor = UIColor.blue
            
            return cell
            
        } else {
            var cell: AddressCell! = tableView.dequeueReusableCell(withIdentifier: AddressCellIdentifier) as? AddressCell
            
            if cell == nil {
                detailTableView.register(UINib(nibName: AddressCellIdentifier, bundle: nil), forCellReuseIdentifier: AddressCellIdentifier)
                cell = tableView.dequeueReusableCell(withIdentifier: AddressCellIdentifier) as? AddressCell
            }
            
            cell.configureCell("Address")
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            let a = PhotosVC.init(nibName: "PhotosVC", bundle: nil)
            self.navigationController?.pushViewController(a, animated: true)
        }
    }
   


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
