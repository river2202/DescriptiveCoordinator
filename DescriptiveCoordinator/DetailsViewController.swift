import UIKit

class DetailsViewController: UIViewController {

  enum Action {
    case back
    case selectDate(Date)
  }
  
  var actionHandler: ActionHandler<Action>?
  
  static func instanciate(actionHandler: ActionHandler<Action>? = nil) -> DetailsViewController {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
    vc.actionHandler = actionHandler
    return vc
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
