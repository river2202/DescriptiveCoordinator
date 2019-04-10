import UIKit

typealias ActionHandler<T> = (T) -> Void
typealias ActionHandler2<T, A> = (T, A) -> Void

struct MainCoordinator {
  var startVc: UINavigationController  {
    let rootVc = UINavigationController()
    let mainPageVc = mainPageViewController(parameters: (rootVc: rootVc, date: Date()))
    rootVc.pushViewController(mainPageVc, animated: false)
    return rootVc
  }
  
  func mainPageViewController(parameters: (rootVc: UINavigationController, date: Date)) -> MainPageViewController {
    return MainPageViewController.instanciate { action in
      switch action {
      case .itemClicked:
        parameters.rootVc.pushViewController(self.detailsViewController(parameters: parameters), animated: true)
      }
    }
  }
  
  func detailsViewController(parameters: (rootVc: UINavigationController, date: Date)) -> DetailsViewController {
    return DetailsViewController.instanciate{ vc, action in
      switch action {
      case .selectDate(let date):
        parameters.rootVc.pushViewController(self.dateSelectViewController(parameters: (rootVc: parameters.rootVc, detailsViewController: vc, date: date)), animated: true)
      case .back:
        parameters.rootVc.popViewController(animated: true)
      }
    }
  }
  
  func dateSelectViewController(parameters: (rootVc: UINavigationController, detailsViewController: DetailsViewController,date: Date)) -> DateSelectViewController {
    return DateSelectViewController.instanciate(date: parameters.date){ action in
      switch action {
      case .selectDate(let date):
        parameters.detailsViewController.update(date: date)
        parameters.rootVc.popViewController(animated: true)
      case .back:
        parameters.rootVc.popViewController(animated: true)
      }
    }
  }
  
}

