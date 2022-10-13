//
//  CustomContentTableView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 28/11/21.
//

import UIKit

open class CustomContentTableView<Payload, Cell: CustomContentTableViewCell<Payload>>: UIView, UITableViewDataSource, UITableViewDelegate {
    var data: [Payload] = []
    var onCellPress: ((Payload) -> Void)?
    weak var constraintHeight: NSLayoutConstraint?
    weak var tableView: UITableView!
    
    required public init(onCellPress: ((Payload) -> Void)?) {
        super.init(frame: .zero)
        self.onCellPress = onCellPress
        translatesAutoresizingMaskIntoConstraints = false
        let constraintHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
        constraintHeight.isActive = true
        self.constraintHeight = constraintHeight
        
        let tableView = UITableView()
        addSubview(tableView)
        tableView.fillSuperView()
        tableView.bounces = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.tableView = tableView
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fillData(data: [Payload]) {
        self.data = data
        tableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.fillData(data: data[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutSubviews()
        let newConstant =  tableView.contentSize.height
        constraintHeight?.constant = newConstant > 0 ? newConstant : 1
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payload = data[indexPath.row]
        onCellPress?(payload)
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        nil
    }
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        0
    }
}

open class CustomContentTableViewCell<Payload>: UITableViewCell {
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    public func fillData(data: Payload) {
        fatalError("fillData(data:) has not been implemented")
    }
}
