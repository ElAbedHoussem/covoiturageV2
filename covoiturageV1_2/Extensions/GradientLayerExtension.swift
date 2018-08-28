import UIKit
@IBDesignable
class GredientLayerExtension: UIView {

    //this class help us the make the menu Dessign
    @IBInspectable var topColor = UIColor.cyan {
        didSet {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var bottomColor = UIColor.yellow{
        didSet {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews() {
        let menuLayer = CAGradientLayer()
        menuLayer.colors = [ bottomColor.cgColor ,  self.backgroundColor , bottomColor.cgColor]
        menuLayer.startPoint = CGPoint (x: 0, y: 0)
        menuLayer.endPoint = CGPoint (x:0 , y: 1 )
        menuLayer.frame = self.bounds
        self.layer.insertSublayer(menuLayer, at: 0)
    }


}
