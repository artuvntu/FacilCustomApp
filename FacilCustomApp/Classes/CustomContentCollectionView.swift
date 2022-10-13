//
//  CustomContentCollectionView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 28/11/21.
//

public class CustomContentCollectionView<Payload, Cell: CustomContentCollectionViewCell<Payload>>: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! Cell
        cell.fillData(data: data[indexPath.row])
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        onCellPress?(data[indexPath.row])
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath){
        collectionView.layoutSubviews()
        constraintHeight.constant = collectionView.contentSize.height
    }
    
    public var data: [Payload] = []
    public var onCellPress: ((Payload) -> Void)?
    public weak var constraintHeight: NSLayoutConstraint!
    public weak var collection: UICollectionView!
    
    public init(onCellPress: ((Payload) -> Void)? = nil) {
        super.init(frame: .zero)
        backgroundColor = .white
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width - 16
        self.onCellPress = onCellPress
        translatesAutoresizingMaskIntoConstraints = false
        let constraintHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: screenWidth)
        constraintHeight.isActive = true
        self.constraintHeight = constraintHeight
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let collection = UICollectionView(frame: .null, collectionViewLayout: layout)
        addSubview(collection)
        collection.backgroundColor = .white
        collection.fillSuperView()
        collection.bounces = false
        collection.register(Cell.self, forCellWithReuseIdentifier: "cell")
        collection.dataSource = self
        collection.delegate = self

        self.collection = collection
    }
    
    
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fillData(data: [Payload]) {
        self.data = data
        collection.reloadData()
    }
    

}
public class CustomContentCollectionViewCell<Payload>: UICollectionViewCell {
    public func fillData(data: Payload) {
        fatalError("fillData(data:) has not been implemented")
    }
}
