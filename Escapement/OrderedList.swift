//
//  OrderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/7/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public struct OrderedList: List {

    // MARK: - Properties

    public var items: [Element]

    // MARK: - Initializers

    public init(items: [Element]) {
        self.items = items
    }

    // MARK: - ListProtocol

    public func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        let indexAttributes = stylesheet.attributes(forSelector: "ol")
        let indexFormatter = indexAttributes[ListItemIndexFormatterAttribute] as? ListItemIndexFormatter ?? { index, _ in
            "\(index)."
        }
        return NSAttributedString(string: indexFormatter(index, depth), attributes: indexAttributes)
    }
}

extension OrderedList: Equatable {
    public static func == (lhs: OrderedList, rhs: OrderedList) -> Bool {
        return lhs.items == rhs.items
    }
}
