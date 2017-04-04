//
//  UnorderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol UnorderedList: Element {
    var items: [Element] { get }
}

extension UnorderedList {
    public func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        guard !items.isEmpty else { return NSAttributedString() }

        let indexAttributes = stylesheet["ul"]
        let attributedString = NSMutableAttributedString()

        for (index, item) in items.enumerated() {
            if index != 0 {
                attributedString.append(NSAttributedString(string: "\n"))
            }
            let itemAttributedString = NSMutableAttributedString()
            itemAttributedString.append(NSAttributedString(string: "\u{2022} ", attributes: indexAttributes))
            itemAttributedString.append(item.attributedString(with: stylesheet))
            attributedString.append(itemAttributedString)
        }
        
        return attributedString
    }
}
