import UIKit

typealias ActionHandler<T> = (T) -> Void
typealias ActionHandler2<T, A> = (T, A) -> Void

struct MainCoordinator {
  var startVc: UINavigationController  {
    let rootVc = UINavigationController()
    let mainPageVc = mainPageViewController(parameters: (rootVc))
    rootVc.pushViewController(mainPageVc, animated: false)
    return rootVc
  }
  
  func mainPageViewController(parameters: (UINavigationController)) -> MainPageViewController {
    return MainPageViewController.instanciate { action in
      switch action {
      case .itemClicked(let index):
        parameters.pushViewController(self.detailsViewController(parameters:  (parameters, index)), animated: true)
      }
    }
  }
  
  func detailsViewController(parameters: (rootVc: UINavigationController, index: Int)) -> DetailsViewController {
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
  
//  var mianVc: MainPageViewController {
//    return create(t: 1, router: { (v, action) in
//      switch action {
//      case .itemClicked(let index):
////        parameters.pushViewController(self.detailsViewController(parameters:  (parameters, index)), animated: true)
//        break
//      }
//    })
//  }
  
//  var router: [(, ()->Void)] = [
//  ]
//
//  func route<V: Coordinateable>(v: V, action: V.Action) {
////    var a: [Coordinateable.Type] = [
//////      DetailsViewController,
////      MainPageViewController.Type
////    ]
//
//    print(v.self)
//  }
  
  func create<V: Coordinateable>(t: V.InitParameters, router: (V.VC, V.Action) -> Void) -> V {
    return V.instanciate(t, actionHandler: router)
  }
}

//protocol Action {}

protocol Coordinateable: AnyObject {
  associatedtype InitParameters
  associatedtype Action
  associatedtype VC = Self
  static func instanciate(_: InitParameters, actionHandler: (VC, Action) -> Void) -> Self
}


//extension DetailsViewController: Coordinator {
//
//}
//extension Coordinator: Hashable {
//
//}
protocol ObjectCreator {
    static func create(data: Data) -> Self?
}

extension Data {
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

extension ObjectCreator where Self: Decodable {
    static func create(data: Data) -> Self? {
        return nil//data.decode(Self.self)
    }
}

struct MyClassA: Decodable {
    var a: Int = 0
}

extension MyClassA: ObjectCreator {
    static func create(data: Data) -> MyClassA? {
        return try? JSONDecoder().decode(MyClassA.self, from: data)
    }
}



