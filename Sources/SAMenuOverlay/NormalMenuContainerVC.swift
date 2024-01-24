//
//  NormalMenuContainerVC.swift
//  DropDownMenuTest
//
//  Created by Ahmed Sallam on 23/01/2024.
//

import UIKit

internal class NormalMenuContainerVC<T>: UIViewController, UIPopoverPresentationControllerDelegate {
    fileprivate unowned let sourceView: UIView

    fileprivate var menuView: DropDownMenuView<T>!
    
    fileprivate var options: [DropDownMenuOption<T>]?
    fileprivate var defaultSelection: DropDownMenuOption<T>? = nil
    fileprivate var didSelectOption: ClosureWithObject<T>? = nil
    
    fileprivate var selectionBackgroundColor: UIColor?
    fileprivate var menuCellHeight: CGFloat?

    init(sourceView: UIView,
         options: [DropDownMenuOption<T>]?,
         displayableTitle: @escaping (T) -> String,
         defaultSelection: T?,
         selectionBackgroundColor: UIColor? = nil,
         menuCellHeight: CGFloat? = nil,
         didSelectOption: ClosureWithObject<T>? = nil) {
        
        self.sourceView = sourceView
        self.didSelectOption = didSelectOption
        self.defaultSelection = defaultSelection != nil ? DropDownMenuOption<T>.init(displayableTitle: displayableTitle(defaultSelection!), value: defaultSelection!) : nil
        
        self.options = options
        
        self.selectionBackgroundColor = selectionBackgroundColor ?? .blue.withAlphaComponent(0.5)
        self.menuCellHeight = menuCellHeight
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferedHeight = self.getAppropriateHeightForDropDownMenu(optionsCount: options?.count ?? 0)
        
        self.preferredContentSize = CGSize(width: self.sourceView.frame.width, height: preferedHeight)
        self.modalPresentationStyle = .popover
        self.popoverPresentationController?.permittedArrowDirections = .up

        menuView = DropDownMenuView<T>(frame: CGRect(x: self.sourceView.frame.origin.x,
                                                         y: self.sourceView.frame.maxY,
                                                         width: self.sourceView.frame.width,
                                                         height: preferedHeight))
        
        menuView.options = options ?? []
        menuView.defaultSelectedOption = defaultSelection
        menuView.selectedHighlightColor = selectionBackgroundColor
        menuView.cellHeight = menuCellHeight
        
        menuView.onSelection = { item in
            self.dismiss(animated: true)
            self.didSelectOption?(item?.value)
        }
                

        self.view = menuView
    }
    
    fileprivate func getAppropriateHeightForDropDownMenu(optionsCount: Int) -> CGFloat {
        let currentCellHeight = (menuCellHeight ?? defaultCellHeight)
        
        let fullHeight = CGFloat(optionsCount) * currentCellHeight
        let largestHeight = 3 * currentCellHeight
        
        return fullHeight <= largestHeight ? fullHeight : largestHeight
    }
    
    public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .popover
    }
}
