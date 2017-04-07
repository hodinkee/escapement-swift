//
//  OrderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/7/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public struct OrderedList: ListProtocol {

    // MARK: - Properties

    public var items: [Element]

    // MARK: - Initializers

    public init(items: [Element]) {
        self.items = items
    }

    // MARK: - ListProtocol

    public func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        return NSAttributedString(string: "\(index).", attributes: stylesheet.attributes(forSelector: "ol"))
    }
}
