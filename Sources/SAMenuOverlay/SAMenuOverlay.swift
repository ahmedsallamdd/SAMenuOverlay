// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public typealias VoidClosure = () -> Void
public typealias ClosureWithObject<T> = (T?) -> Void

let defaultCellHeight: CGFloat = 60
let defaultSelectionHightlightedColor: UIColor = .blue.withAlphaComponent(0.2)
