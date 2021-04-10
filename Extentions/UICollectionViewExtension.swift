//
//  UICollectionViewExtension.swift
//  GroceriesApp
//
//  Created by Ilya Buldin on 28.03.2021.
//

import UIKit

extension UICollectionReusableView {
    class var defaultReuseIdentifier: String {
        return String(describing: self).appending("ReuseIdentifier")
    }
}

extension UICollectionView {
    
    func registerClass<T: UICollectionViewCell>(for cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.defaultReuseIdentifier)
    }
    
    func registerHeaderClass<T: UICollectionReusableView>(for cellClass: T.Type) {
        register(cellClass, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellClass.defaultReuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(for cellClass: T.Type) {
        let nib = UINib(nibName: String(describing: cellClass), bundle: nil)
        register(nib, forCellWithReuseIdentifier: cellClass.defaultReuseIdentifier)
    }
    
    func getCell<T: UICollectionViewCell>(withClass cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
                withReuseIdentifier: cellClass.defaultReuseIdentifier,
                for: indexPath)
                as? T else {
            fatalError("""
                    Error: cell with identifier: \(cellClass.defaultReuseIdentifier)
                    for index path: \(indexPath) is not \(T.self)
                    """)
        }
        return cell
    }
    
    func getHeader<T: UICollectionReusableView>(withClass cellClass: T.Type, for indexPath: IndexPath, kind: String) -> T {
        
        guard let cell = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellClass.defaultReuseIdentifier, for: indexPath)
                as? T else {
            fatalError("""
                    Error: cell with identifier: \(cellClass.defaultReuseIdentifier)
                    for index path: \(indexPath) is not \(T.self)
                    """)
        }
        return cell
    }
}

