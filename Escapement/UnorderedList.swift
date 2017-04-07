//
//  UnorderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/7/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public struct UnorderedList: List {

    // MARK: - Properties

    public var items: [Element]

    // MARK: - Initializers

    public init(items: [Element]) {
        self.items = items
    }

    // MARK: - ListProtocol

    public func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        let indexAttributes = stylesheet.attributes(forSelector: "ul")
        let indexFormatter = indexAttributes[ListItemIndexFormatterAttribute] as? ListItemIndexFormatter ?? { _, depth in
            depth % 2 == 0 ? "\u{2022}" : "\u{25E6}"
        }
        return NSAttributedString(string: indexFormatter(index, depth), attributes: indexAttributes)
    }
}
