import UIKit

class DateSelectViewController: UIViewController {
  enum Action {
    case back
    case selectDate(Date)
  }
  
  var actionHandler: ActionHandler<Action>?
  
  static func instanciate(date: Date, actionHandler: ActionHandler<Action>? = nil) -> DateSelectViewController {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DateSelectViewController") as! DateSelectViewController
    vc.actionHandler = actionHandler
    vc.date = date
    return vc
  }
  
  var date: Date!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func dateSelected(_ sender: Any) {
    actionHandler?(.selectDate(Date()))
  }
  
  @IBAction func onBackTapped(_ sender: Any) {
    actionHandler?(.back)
  }
  
}

