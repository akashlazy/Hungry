
import UIKit
import Kingfisher

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var btn1: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisines: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    
    @IBOutlet weak var viewRating: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = UIColor.clear
        
        setCorner(btn1, radius: 8)
      
        
        viewRating.layer.cornerRadius = 3
        viewRating.layer.masksToBounds = true
        
        lblName.textColor = CustomColor.darker_gray()
        
        lblCuisines.textColor = CustomColor.dark_gray()
        
        lblAddress.textColor = CustomColor.light_gray()
        
        lblCost.textColor = CustomColor.grayLight()
    }
    
    private func setCorner(_ btn: UIButton, radius: CGFloat) {
        btn.layer.cornerRadius = radius
        btn.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureRestaurantCell(_ arr: [ArrRestaurants], index: Int) {
        let restaurant = arr[index]
        
        lblName.text = restaurant.name
        lblCuisines.text = restaurant.cuisines
        lblAddress.text = restaurant.locality
        lblRating.text = "" + restaurant.rating
        lblCost.text = "₹" + restaurant.avgCost + " for two people (approx.)"
        
        let url = URL(string: restaurant.thumb)
        
        btn1.kf.setImage(with: url, for: .normal, placeholder: nil, options: [.transition(.fade(1))], progressBlock: { receivedSize, totalSize in
            print("\(receivedSize)/\(totalSize)")
        }, completionHandler: { image, error, cacheType, imageURL in
//            self.imageName = image
            
            if error != nil {
//                self.imageName = UIImage(named: "ic_person_light_gray_24dp.png")
//                self.profileImageButton.setImage(self.imageName, for: .normal)
            }
            print("Finished")
        })
        
        viewRating.backgroundColor = UIColor(rgba: "#\(restaurant.color)")
    }
    
}
