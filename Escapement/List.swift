//
//  List.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol ListProtocol: Styleable {
    var items: [Element] { get }

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString
}

extension ListProtocol {
    public func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString {
        if items.isEmpty {
            return NSAttributedString()
        }

        return attributedString(with: stylesheet, depth: 0)
    }

    private func attributedString(with stylesheet: Stylesheet, depth: Int) -> NSAttributedString {
        if items.isEmpty {
            return NSAttributedString()
        }

        var trueIndex: Int = 0

        let attributedString = NSMutableAttributedString()

        for (index, item) in items.enumerated() {
            if index > 0 {
                attributedString.append(NSAttributedString(string: "\n"))
            }

            switch item {
            case .orderedList(let list):
                attributedString.append(list.attributedString(with: stylesheet, depth: depth + 1))
            case .unorderedList(let list):
                attributedString.append(list.attributedString(with: stylesheet, depth: depth + 1))
            case .paragraph(let paragraph):
                let itemAttributedString = NSMutableAttributedString()
                let indent = Array(repeating: "\t", count: depth).joined(separator: "")
                itemAttributedString.append(NSAttributedString(string: indent))
                itemAttributedString.append(attributedIndex(with: stylesheet, index: trueIndex + 1, depth: depth))
                itemAttributedString.append(NSAttributedString(string: " "))
                itemAttributedString.append(paragraph.makeAttributedString(stylesheet: stylesheet))
                attributedString.append(itemAttributedString)
                trueIndex += 1
            }
        }

        return NSAttributedString(attributedString: attributedString)
    }
}
