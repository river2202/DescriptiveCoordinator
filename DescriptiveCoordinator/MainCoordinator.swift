import UIKit

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
        parameters.rootVc.pushViewController(self.detailsViewController(), animated: true)
      }
    }
  }
  
  func detailsViewController() -> DetailsViewController {
    return DetailsViewController.instanciate{ action in
      
    }
  }
  
//
//  var router = [
//    (MainPageViewController, []),
//
//  ]
}

