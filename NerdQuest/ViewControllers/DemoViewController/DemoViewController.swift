//
//  DemoViewController.swift
//  TestCollectionView
//
//  Created by Luiz Dias. on 12/05/16.
//  Copyright © 2016 Luiz Dias. All rights reserved.
//

import UIKit
import SwiftyJSON
//import Alamofire
import RealmSwift

// APIProtocol was removed :/
// TODO: Include APIProtocol again
class DemoViewController: ExpandingViewController {
    
    var cellsIsOpen = [Bool]()
    typealias ItemInfo = (imageName: String, title: String)
    var items: [ItemInfo] = [
        ("item0", "Sci-Fi"),
        ("item1", "Video Games"),
        ("item2", "Horror e Zombies"),
        ("item3", "Medieval e Fantasia"),
        ("item4","Video Games"),
        ("item4","Filler"),
        ("item4","Filler"),
        ("item4","Filler")
    ]
//    var myAPI = API()
    
    // Get the default Realm
    let realm = try! Realm()
    
    @IBOutlet weak var pageLabel: UILabel!

    var categoriesList : NSMutableArray = []
    
    override func viewWillAppear(_ animated: Bool) {
        
// This reload causes a bug in the transition animation effect and it turns out it isn't necessary at all.
//        self.collectionView!.reloadSections(NSIndexSet.init(index: 0))
        
    }

    
}

// MARK: life cicle

extension DemoViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()

//  Previous json version, with wrong filler images
//    myAPI.get("/576892d13c000042007c3df8", delegate: self)
    
//    The correct one:
//    myAPI.get("/57c3b4bb100000061c875cef", delegate: self)
    
    
    // Query Realm for all categories
    let categories = realm.objects(Category.self)
    
    if !categories.isEmpty {        
        items = []
        
        for result in categories {
            var category = Category()
            category = result
            categoriesList.add(category)
            let item:ItemInfo = ("item" + category.id, title: category.title)
            items.append(item)
        }
    }

    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = UIColor.clear


//    let cache = NSCache()
//    var categoriesList : NSMutableArray = []
//    let myObject: ExpensiveObjectClass
//
//    if let cachedVersion = cache.objectForKey("CachedObject") as? ExpensiveObjectClass {
//        // use the cached version
//        myObject = cachedVersion
//    } else {
//        // create it from scratch then store in the cache
//        myObject = ExpensiveObjectClass()
//        cache.setObject(myObject, forKey: "CachedObject")
//    }
    
    registerCell()
    fillCellIsOpenArray()
    addGestureToView(toView: collectionView!)
    configureNavBar()
  }

}

// MARK: Helpers
extension DemoViewController {
  
    func registerCell() {
        let nib = UINib(nibName: String(describing: DemoCollectionViewCell.self), bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: String(describing: DemoCollectionViewCell.self))
    }

    func fillCellIsOpenArray() {
        for _ in 0..<items.count {
          cellsIsOpen.append(false)
        }
    }

    func getViewController() -> ExpandingTableViewController {
        let storyboard = UIStoryboard(storyboard: .Main)
        let toViewController: DemoTableViewController = storyboard.instantiateViewController()
        return toViewController
    }

    func configureNavBar() {
        navigationItem.leftBarButtonItem?.image = navigationItem.leftBarButtonItem?.image!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
    }
}

// MARK: Gesture
extension DemoViewController {
  
    // TODO: I
    func addGestureToView(toView: UIView) {
        let gesutereUp = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(sender:)))){
          $0.direction = .up
        }
    
        let gesutereDown = Init(UISwipeGestureRecognizer(target: self, action: #selector(DemoViewController.swipeHandler(sender:)))) {
            $0.direction = .down
        }
        toView.addGestureRecognizer(gesutereUp)
        toView.addGestureRecognizer(gesutereDown)
    }

    func swipeHandler(sender: UISwipeGestureRecognizer) {
        let indexPath = IndexPath(row: currentIndex, section: 0)
        guard case let cell as DemoCollectionViewCell = collectionView?.cellForItem(at: indexPath) else {
          return
        }
    
        // double swipe Up transition
        if cell.isOpened == true && sender.direction == .up {
          pushToViewController(getViewController())
          
          if case let rightButton as AnimatingBarButton = navigationItem.rightBarButtonItem {
            rightButton.animationSelected(selected: true)
          }
        }
    
        let open = sender.direction == .up ? true : false
        cell.cellIsOpen(open)
        cellsIsOpen[indexPath.row] = cell.isOpened

    }
}

// MARK: UIScrollViewDelegate
extension DemoViewController {
  
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageLabel.text = "\(currentIndex+1)/\(items.count)"
    }
}

// MARK: UICollectionViewDataSource
extension DemoViewController {
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard case let cell as DemoCollectionViewCell = cell else {
            return
            }
    
        let index = indexPath.row % 4
        let info = items[index]
        
        if categoriesList.count != 0 {
            let category = categoriesList[indexPath.row] as! Category
            cell.backgroundImageView?.image = UIImage(named: info.imageName)
            cell.customTitle.text = category.title
            cell.cellIsOpen(cellsIsOpen[indexPath.row], animated:  false)
            
        }else {
            cell.backgroundImageView?.image = UIImage(named: info.imageName)
            cell.customTitle.text = info.title
            cell.cellIsOpen(cellsIsOpen[indexPath.row], animated: false)
            }
  }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case let cell as DemoCollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) else {
          return
        }
        if currentIndex != indexPath.row { return }
        
        if cell.isOpened == false {
          cell.cellIsOpen(true)
        } else {
          pushToViewController(getViewController())
          
          if case let rightButton as AnimatingBarButton = navigationItem.rightBarButtonItem {
            rightButton.animationSelected(selected: true)
          }
        }
  }
}

// MARK: UICollectionViewDataSource

extension DemoViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    if categoriesList.count != 0 {
        return categoriesList.count
    } else {
        // TODO: If the can't aquire items through Network nor our local Realm, we must show an Alert!
        return items.count
    }
    
  }
  
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath as IndexPath) as! DemoCollectionViewCell
    
//    cell.delegate = self
    if categoriesList.count != 0{
        print("retornou uma celula com conteúdo da requisicao")
        let category = categoriesList[indexPath.row] as! Category
        
        //TODO: This is probably going to be deleted after we have proper images on Category beans
//        let index = indexPath.row % 4
//        let info = items[index]

        _ = category.image
        cell.backgroundImageView.image = nil
        //TODO: Networking disabled for this MVP version. Re-enable it here:
//        cell.request?.cancel()
//        cell.request = Alamofire.request(imageURL, method: .get).responseImage() {
//            [weak self] response in
//            if let image = response.result.value {
//                cell.backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
//                cell.backgroundImageView.image = image
//            }
//        }
        cell.backgroundImageView.image = UIImage(named: "namePlaceholder")
        cell.customTitle.text = category.title
        
        //TODO: Here is the place where the app is crashing for now (index out of range)
        cell.cellIsOpen(cellsIsOpen[indexPath.row], animated:  false)
                
        return cell
        
    } else {
        return collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DemoCollectionViewCell.self), for: indexPath as IndexPath)
    }
    
  }
}

