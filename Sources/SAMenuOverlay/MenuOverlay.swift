//
//  NormalMenuOverlay.swift
//  DropDownMenuTest
//
//  Created by Ahmed Sallam on 23/01/2024.
//

import UIKit

public class NormalMenuOverlay<T> {
    fileprivate var menuVC: NormalMenuContainerVC<T>!
    
    fileprivate unowned let sourceView: UIView
    fileprivate unowned let parentViewController: UIViewController

    fileprivate var options: [DropDownMenuOption<T>]?
    fileprivate var selectedItem: T?
    
    public var dataSource: [T]?
    public var displayableItemTitle: (T) -> String
    public var defaultSelection: T? = nil
    public var didSelectOption: ClosureWithObject<T>? = nil
    
    public var selectionBackgroundColor: UIColor?
    public var menuCellHeight: CGFloat?

    public init(parentViewController: UIViewController,
                sourceView: UIView) {
        
        self.parentViewController = parentViewController
        self.sourceView = sourceView
        self.displayableItemTitle = { _ in return ""}
    }
    
    public func showList() {
        self.options = dataSource?.map({ DropDownMenuOption<T>.init(displayableTitle: displayableItemTitle($0), value: $0) })
        
        self.menuVC = NormalMenuContainerVC(sourceView: sourceView,
                                            options: options,
                                            displayableTitle: displayableItemTitle,
                                            defaultSelection: selectedItem ?? defaultSelection,
                                            selectionBackgroundColor: selectionBackgroundColor,
                                            didSelectOption: { [weak self] selectedItem in
            self?.selectedItem = selectedItem
            self?.didSelectOption?(selectedItem)
        })
        
        menuVC.modalPresentationStyle = .popover
        menuVC.popoverPresentationController?.delegate = menuVC
        menuVC.popoverPresentationController?.sourceView = parentViewController.view
        menuVC.popoverPresentationController?.sourceRect = sourceView.frame
        menuVC.popoverPresentationController?.permittedArrowDirections = .up
        parentViewController.present(menuVC, animated: true)        
    }
}
