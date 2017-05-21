import UIKit
import PlaygroundSupport


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}


class LabelViewController : UIViewController {

    
    let square = UIView(frame: CGRect(x: 170, y: 100, width:90
        , height: 90))
    
    let circle = UIView(frame: CGRect(x:300, y: 120, width: 50.0, height: 50.0))
    
    var snap : UISnapBehavior!
    var anim : UIDynamicAnimator!
    let button = UIButton(frame: CGRect(x: 90, y: 300, width: 100, height: 50))
    
    
    var isBall = false
    
    
    let animButton = UIButton(frame: CGRect(x: 200, y: 300, width: 100, height: 50))
    
    let redSlider = UISlider(frame: CGRect(x: 110, y: 400, width: 200, height: 50))
    
    
    let greenSlider = UISlider(frame: CGRect(x: 110, y: 450, width: 200, height: 50))
    
    
      let blueSlider = UISlider(frame: CGRect(x: 110, y: 500, width: 200, height: 50))

    
    override func viewDidLoad() {
        
      let col=UIColor(red: 226, green: 242, blue: 252)
        
        
        
        view.layer.backgroundColor = col.cgColor
        
        
        square.layer.cornerRadius = 5.0
        
        square.backgroundColor = UIColor.blue
        
        
        view.addSubview(square)
        
        anim = UIDynamicAnimator(referenceView: view)
        
        
        
        button.backgroundColor = UIColor.darkGray
        button.addTarget(self, action: #selector(changeBall), for: .touchUpInside)
        button.setTitle("Circle", for: .normal)
        
        
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
        
         animButton.backgroundColor = UIColor.darkGray
        animButton.setTitle("Animate", for: .normal)
        view.addSubview(animButton)
        
        animButton.addTarget(self, action: #selector(animations), for: .touchUpInside)
        
       
        view.addSubview(redSlider)
        
       
        
        view.addSubview(greenSlider)
        
     
        
        view.addSubview(blueSlider)
        
        redSlider.addTarget(self, action: #selector(chaColor), for: .touchDragInside)
        
        greenSlider.addTarget(self, action: #selector(chaColor), for: .touchDragInside)
        
        blueSlider.addTarget(self, action: #selector(chaColor), for: .touchDragInside)
        
        
        
    }
    
    func buttonClicked(sender: UIButton) {
        if button.currentTitle == "Circle" { sender.setTitle("Square", for: .normal)
        } else {
            button.setTitle("Circle", for: .normal)
        }
    }
    func changeBall() {
        isBall = !isBall
        let animation = CABasicAnimation()
        let halfWidth = square.frame.width / 2
        let cornerRadius: CGFloat = isBall ? halfWidth : 10
        animation.keyPath = "cornerRadius"
        animation.fromValue = isBall ? 10 : halfWidth
        animation.toValue = cornerRadius
        animation.duration = 0.2
        square.layer.cornerRadius = cornerRadius
        square.layer.add(animation, forKey: "radius")
    }
    
    
 
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        anim.removeAllBehaviors()
        
        for touch in touches{
            var loc = touch.location(in: self.view)
            
            if loc.x > view.frame.size.width - 50{
                loc.x = view.frame.size.width - 50
            }
            
            if loc.y > 250{
                loc.y = 250
                
                
            }
            
            if loc.x < 50 {
            
                loc.x = 50
            }
            
            if loc.y < 50{
                
                loc.y = 50
            }
            
            snap=UISnapBehavior(item: square, snapTo: loc)
            snap.damping=0.2
            anim.addBehavior(snap)
            
        }
    }
    
    func chaColor(sender:UISlider){
        let levelR = CGFloat(redSlider.value)
        let levelG = CGFloat(greenSlider.value)
        let levelB = CGFloat(blueSlider.value)
        let color = UIColor(red: levelR, green: levelG, blue: levelB, alpha: 1.0)
        square.backgroundColor=color
        
        redSlider.thumbTintColor=UIColor(red: levelR, green: 0, blue: 0, alpha: 1.0)
        redSlider.tintColor = UIColor(red: levelR, green: 0, blue: 0, alpha: 1.0)
        
        greenSlider.thumbTintColor=UIColor(red: 0, green: levelG, blue: 0, alpha: 1.0)
        greenSlider.tintColor = UIColor(red: 0, green: levelG, blue: 0, alpha: 1.0)
        
        
        blueSlider.thumbTintColor=UIColor(red: 0, green: 0, blue: levelB, alpha: 1.0)
        
        blueSlider.tintColor = UIColor(red: 0, green: 0, blue: levelB, alpha: 1.0)
        
    }
    
    func animations(){
        UIView.animate(withDuration: 2.0, animations: { () -> Void in
           
            let scaleTransform = CGAffineTransform(scaleX: 4.0, y: 4.0)
            self.square.transform = scaleTransform
            
            let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
                        self.square.transform = rotationTransform
     })
}

    
    }
    


PlaygroundPage.current.liveView = LabelViewController()
