import UIKit

class DetailsViewController: UIViewController {

  enum Action {
    case back
    case selectDate(Date)
  }
  
  var actionHandler: ActionHandler2<DetailsViewController, Action>?
  
  static func instanciate(actionHandler: ActionHandler2<DetailsViewController, Action>? = nil) -> DetailsViewController {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    vc.actionHandler = actionHandler
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func update(date: Date) {
    
  }
  
  @IBAction func selectDateTapped(_ sender: Any) {
    actionHandler?(self, .selectDate(Date()))
  }
}
