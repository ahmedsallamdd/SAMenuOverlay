//
//  DropDownMenuViews.swift
//  DropDownMenuTest
//
//  Created by Ahmed Sallam on 01/05/2023.
//

import UIKit

class DropDownMenuView<T>: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var tableView = UITableView()
    
    var onSelection: ClosureWithObject<DropDownMenuOption<T>>? = {_ in}
    var selectedHighlightColor: UIColor?
    var cellHeight: CGFloat?
    
    var options = [DropDownMenuOption<T>]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var defaultSelectedOption: DropDownMenuOption<T>? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        
        self.setupTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupTableView() {
        tableView.backgroundColor = UIColor.white
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(tableView)
        
        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight ?? defaultCellHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = options[indexPath.row].displayableTitle
        cell.tintColor = .white

        if let defaultSelectedOption, defaultSelectedOption.displayableTitle == options[indexPath.row].displayableTitle {
            cell.accessoryType = .checkmark
            cell.backgroundColor = selectedHighlightColor ?? defaultSelectionHightlightedColor
            cell.textLabel?.textColor = .white
        } else {
            cell.textLabel?.textColor = .darkGray
            cell.backgroundColor = .white
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.onSelection?(self.options[indexPath.row])
    }
}
