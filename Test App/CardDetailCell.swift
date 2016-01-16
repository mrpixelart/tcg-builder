import UIKit

class CardDetailCell: UITableViewCell {
    
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var numberLabel: UILabel!
    
    func setCell(cardName: String) {
      
    }
    
    @IBAction func stepperChanged(sender: AnyObject) {
        numberLabel.text = String(format: "%.0f", stepper.value)
    }
    
}