
import UIKit

@IBDesignable

class CardView: UIView {
    
    @IBInspectable var corRadius: CGFloat = 10
    
    @IBInspectable var shadowOffsetWidth: CGFloat = 0
    @IBInspectable var shadowOffsetHeight: CGFloat = 0.4
    @IBInspectable var shadoColor: UIColor? = UIColor.black
    @IBInspectable var shadoOpacity: Float = 0.1
    
    override func layoutSubviews() {
        layer.cornerRadius = corRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: corRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadoColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadoOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
