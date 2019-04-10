import UIKit


class MainPageViewController: UIViewController {
  
  enum Action {
    case itemClicked(Int)
  }
  
  var actionHandler: ActionHandler<Action>?
  
  static func instanciate(actionHandler: ActionHandler<Action>? = nil) -> MainPageViewController {
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainPageViewController
    vc.actionHandler = actionHandler
    return vc
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.delegate = self
    tableView.dataSource = self
  }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    actionHandler?(.itemClicked(indexPath.row))
  }
  
}


