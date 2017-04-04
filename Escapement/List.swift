//
//  List.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol List: Element {
    var items: [Element] { get }

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString
}

extension List {
    public func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        guard !items.isEmpty else { return NSAttributedString() }

        return attributedString(with: stylesheet, depth: 0)
    }

    private func attributedString(with stylesheet: Stylesheet, depth: Int) -> NSAttributedString {
        guard !items.isEmpty else { return NSAttributedString() }

        let attributedString = NSMutableAttributedString()

        for (index, item) in items.enumerated() {
            if index != 0 {
                attributedString.append(NSAttributedString(string: "\n"))
            }
            if let list = item as? List {
                attributedString.append(list.attributedString(with: stylesheet, depth: depth + 1))
            }
            else {
                let itemAttributedString = NSMutableAttributedString()
                let indent = Array(repeating: "\t", count: depth).joined(separator: "")
                itemAttributedString.append(NSAttributedString(string: indent))
                itemAttributedString.append(attributedIndex(with: stylesheet, index: index + 1, depth: depth))
                itemAttributedString.append(NSAttributedString(string: " "))
                itemAttributedString.append(item.attributedString(with: stylesheet))
                attributedString.append(itemAttributedString)
            }
        }

        return attributedString
    }
}
