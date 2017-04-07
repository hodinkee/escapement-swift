//
//  UnorderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/7/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public struct UnorderedList: ListProtocol {

    // MARK: - Properties

    public var items: [Element]

    // MARK: - Initializers

    public init(items: [Element]) {
        self.items = items
    }

    // MARK: - ListProtocol

    public func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        let bullet = depth % 2 == 0 ? "\u{2022}" : "\u{25E6}"
        return NSAttributedString(string: bullet, attributes: stylesheet.attributes(forSelector: "ul"))
    }
}
