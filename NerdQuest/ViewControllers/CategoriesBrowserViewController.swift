//
//  CategoriesBrowserViewController.swift
//  NerdQuest
//
//  Created by Luiz Fernando Aquino Dias on 22/05/17.
//  Copyright © 2017 Town Tree. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CategoriesBrowserViewController: UIViewController, UICollectionViewDelegateFlowLayout
{
    // MARK: - IBOutlets
    
//    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
//    @IBOutlet weak var currentUserProfileImageButton: UIButton!
//    @IBOutlet weak var currentUserFullNameButton: UIButton!
    
    // MARK: - UICollectionViewDataSource
    fileprivate var categories = Category.createCategories()
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let flowLayout = CategoriesCollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 10, right: 30)
        flowLayout.itemSize = CGSize(width: 308, height: 526)
        
        //UINib *cellNib = [UINib nibWithNibName:@"cvCell" bundle:nil];
        let cellNib = UINib(nibName: "CategoriesCollectionViewCell", bundle: nil)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.register(cellNib, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .orange
        
        self.view.addSubview(collectionView)
    }
    
    fileprivate struct Storyboard {
        static let CellIdentifier = "collectionCell"
    }
}

extension CategoriesBrowserViewController : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.CellIdentifier, for: indexPath) as! CategoriesCollectionViewCell
        
        cell.category = self.categories[indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

//extension CategoriesBrowserViewController : UIScrollViewDelegate
//{
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
//    {
//        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
//    
//}

//extension CategoriesBrowserViewController : UICollectionViewFlowLayout {
//    
//    override func targetContentOffset(
//        forProposedContentOffset proposedContentOffset: CGPoint,
//        withScrollingVelocity velocity: CGPoint
//        ) -> CGPoint {
//        var _proposedContentOffset = CGPoint(
//            x: proposedContentOffset.x, y: proposedContentOffset.y
//        )
//        var offSetAdjustment: CGFloat = CGFloat.greatestFiniteMagnitude
//        let horizontalCenter: CGFloat = CGFloat(
//            proposedContentOffset.x + (self.collectionView!.bounds.size.width / 2.0)
//        )
//        
//        let targetRect = CGRect(
//            x: proposedContentOffset.x,
//            y: 0.0,
//            width: self.collectionView!.bounds.size.width,
//            height: self.collectionView!.bounds.size.height
//        )
//        
//        let array: [UICollectionViewLayoutAttributes] =
//            self.layoutAttributesForElements(in: targetRect)!
//                as [UICollectionViewLayoutAttributes]
//        for layoutAttributes: UICollectionViewLayoutAttributes in array {
//            if layoutAttributes.representedElementCategory == UICollectionElementCategory.cell {
//                let itemHorizontalCenter: CGFloat = layoutAttributes.center.x
//                if abs(itemHorizontalCenter - horizontalCenter) < abs(offSetAdjustment) {
//                    offSetAdjustment = itemHorizontalCenter - horizontalCenter
//                }
//            }
//        }
//        
//        var nextOffset: CGFloat = proposedContentOffset.x + offSetAdjustment
//        
//        repeat {
//            _proposedContentOffset.x = nextOffset
//            let deltaX = proposedContentOffset.x - self.collectionView!.contentOffset.x
//            let velX = velocity.x
//            
//            if
//                deltaX == 0.0 || velX == 0 || (velX > 0.0 && deltaX > 0.0) ||
//                    (velX < 0.0 && deltaX < 0.0)
//            {
//                break
//            }
//            
//            if velocity.x > 0.0 {
//                nextOffset = nextOffset + self.snapStep()
//            } else if velocity.x < 0.0 {
//                nextOffset = nextOffset - self.snapStep()
//            }
//        } while self.isValidOffset(offset: nextOffset)
//        
//        _proposedContentOffset.y = 0.0
//        
//        return _proposedContentOffset
//    }
//    
//    func isValidOffset(offset: CGFloat) -> Bool {
//        return (offset >= CGFloat(self.minContentOffset()) &&
//            offset <= CGFloat(self.maxContentOffset()))
//    }
//    
//    func minContentOffset() -> CGFloat {
//        return -CGFloat(self.collectionView!.contentInset.left)
//    }
//    
//    func maxContentOffset() -> CGFloat {
//        return CGFloat(
//            self.minContentOffset() + self.collectionView!.contentSize.width - self.itemSize.width
//        )
//    }
//    
//    func snapStep() -> CGFloat {
//        return self.itemSize.width + self.minimumLineSpacing
//    }
//}
