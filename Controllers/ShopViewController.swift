//
//  TopRatedViewController.swift
//  GroceriesApp
//
//  Created by Ilya Buldin on 03.03.2021.
//

import UIKit


class ShopViewController: UIViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    var coordinator: Coordinator?
    
    
    let colours: [UIColor] = [.red, .blue, .yellow, .purple]
    
    private let cellId = "cellId"
    let collectionViewHeaderReuseIdentifier = "MyHeaderClass"
    private let advertisementCellId = "advertisementCellId"
    private var scrollView = UIScrollView()
    private lazy var advertisementCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .init(x: 23.5, y: 112, width: 368, height: 115), collectionViewLayout: makeAdvertisementCollectionViewLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: advertisementCellId)
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var mainCV: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(MyHeaderFooterClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: collectionViewHeaderReuseIdentifier)

        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.dataSource = self
        return collectionView
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

// MARK: - UI Setup
extension ShopViewController {
    
    
    private func setupUI() {
        self.view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        addNavBarImage()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.showsVerticalScrollIndicator = false
        
        scrollView.addSubview(advertisementCollectionView)
        advertisementCollectionView.backgroundColor = .white
        advertisementCollectionView.isPagingEnabled = true
        advertisementCollectionView.showsHorizontalScrollIndicator = false
        advertisementCollectionView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        
        scrollView.addSubview(mainCV)
        mainCV.frame = view.bounds
        mainCV.backgroundColor = .white
        mainCV.topAnchor.constraint(equalTo: advertisementCollectionView.bottomAnchor, constant: 80).isActive = true
        mainCV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainCV.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        mainCV.isScrollEnabled = false
    }
    
    private func addNavBarImage() {
        let image = #imageLiteral(resourceName: "Image")
        let imageView = UIImageView(image: image)
        
        navigationItem.titleView = imageView
        navigationItem.titleView?.frame = CGRect(x: 0, y: 0, width: 26.48, height: 30.8)
        navigationItem.titleView?.contentMode = .scaleAspectFit
    }
    
    //MARK: - Helper Method
    
    private func makeAdvertisementCollectionViewLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.itemSize = CGSize(width: 368, height: 115)
            flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
            
            return flowLayout
        }()
        return layout
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            switch sectionNumber {
            case 0: return self.thirdLayoutSection()
            default: return self.thirdLayoutSection()
            }
        }
    }
    
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalWidth(0.5))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 20
        
        
        return section
    }
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 15
        
        
        
        return section
    }
    
    private func thirdLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 15
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(173), heightDimension: .absolute(248))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        let footerHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                      heightDimension: .absolute(50.0))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)

        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    
    
}




extension ShopViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == advertisementCollectionView {
            return 1
        }
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == advertisementCollectionView {
            return 4
        }
        switch section {

        case 0:
            return 3
        default:
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == advertisementCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: advertisementCellId, for: indexPath)
            cell.backgroundColor = colours[indexPath.row]
            
            cell.layer.cornerRadius = 8
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 18
        
        return cell
    }
    
    


    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        print("UICollectionViewDelegateFlowLayout")
        switch kind {
        
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionViewHeaderReuseIdentifier, for: indexPath) as! MyHeaderFooterClass
        
            headerView.backgroundColor = UIColor.blue
    
        headerView.titleLabel.text = "Header"
            return headerView
        
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       print("referenceSizeForHeaderInSection")
       return CGSize(width: collectionView.frame.width, height: 30.0)
   }
    
    func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    
        let layoutAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, with: indexPath)
    
        if elementKind == UICollectionView.elementKindSectionHeader {
            layoutAttributes.frame = CGRect(x: 0.0, y: 0.0, width: 200, height: 50) //  contentWidth, height: headerHeight)
            //            layoutAttributes.zIndex = Int.max - 3
        }
    
        return layoutAttributes
    }
}


class MyHeaderFooterClass: UICollectionReusableView {

    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.purple
    
        // Customize here
        addSubview(titleLabel)
        print("MyHeaderFooterClass")
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.sizeToFit()
        titleLabel.frame.origin = CGPoint(x: 15, y: 10)
    }
}
