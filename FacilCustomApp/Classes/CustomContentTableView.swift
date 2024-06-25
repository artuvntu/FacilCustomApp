//
//  CustomContentTableView.swift
//  FacilApp
//
//  Created by Arturo Ventura on 28/11/21.
//

import UIKit

open class CustomContentTableView<Payload, Cell: CustomContentTableViewCell<Payload>>: UIView, UITableViewDataSource, UITableViewDelegate {
    public var data: [Payload] = []
    public var onCellPress: ((Payload) -> Void)?
    public weak var constraintHeight: NSLayoutConstraint?
    public weak var tableView: UITableView!
    public var getHeader: ((Int)->UIView?)?
    public var getFooter: ((Int)->UIView?)?
    required public init(onCellPress: ((Payload) -> Void)? = nil, nestedScroll: Bool = false, getHeader: ((Int)->UIView?)? = nil, getFooter: ((Int)->UIView?)? = nil) {
        self.getHeader = getHeader
        self.getFooter = getFooter
        super.init(frame: .zero)
        self.onCellPress = onCellPress
        if nestedScroll {
            translatesAutoresizingMaskIntoConstraints = false
            let constraintHeight = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 1)
            constraintHeight.isActive = true
            self.constraintHeight = constraintHeight
        }
        let tableView = UITableView()
        addSubviewFill(tableView)
        tableView.bounces = false
        tableView.register(Cell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.delaysContentTouches = false
        
        self.tableView = tableView
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func fillData(data: [Payload]) {
        self.data = data
        tableView.reloadData()
    }
    
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        cell.fillData(data: data[indexPath.row])
        return cell
    }
    
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutSubviews()
        let newConstant =  tableView.contentSize.height
        constraintHeight?.constant = newConstant > 0 ? newConstant : 1
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let payload = data[indexPath.row]
        onCellPress?(payload)
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    open func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        nil
    }
    open func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        0
    }
    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        getHeader?(section)
    }
    
    open func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        getFooter?(section)
    }
}

open class CustomContentTableViewCell<Payload>: UITableViewCell {
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.setupView(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder: NSCoder) {
        fatalError()
    }
    
    open func setupView(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        // Setup here view
    }
    
    open func fillData(data: Payload) {
        fatalError("fillData(data:) has not been implemented")
    }
}
