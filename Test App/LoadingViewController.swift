import UIKit

class LoadingViewController: UIViewController {
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
    let label = UILabel()
    
    override func loadView() {
        self.view = UIView(frame: UIScreen.mainScreen().bounds)
        self.view.backgroundColor = UIColor.whiteColor()
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(spinner)
        self.view.addSubview(label)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = "Loading.."
        spinner.startAnimating()
        
        self.view.removeConstraints(self.view.constraints)
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[label]", options: NSLayoutFormatOptions.AlignAllCenterY, metrics: nil, views: ["label": label, "superview": self.view]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[superview]-(<=1)-[spinner]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["spinner": spinner, "superview": self.view]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[superview]-(<=1)-[label(28)]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label": label, "superview": self.view]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[label]-(6)-[spinner]", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["label": label, "spinner": spinner]))
    }
    
    deinit {
        spinner.stopAnimating()
    }
}
