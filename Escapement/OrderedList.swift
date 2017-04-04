//
//  OrderedList.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol OrderedList: Element {
    var items: [Element] { get }
}

extension OrderedList {
    public func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        guard !items.isEmpty else { return NSAttributedString() }

        let indexAttributes = stylesheet["ol"]
        let attributedString = NSMutableAttributedString()

        for (index, item) in items.enumerated() {
            let itemAttributedString = NSMutableAttributedString()
            itemAttributedString.append(NSAttributedString(string: "\(index + 1). ", attributes: indexAttributes))
            itemAttributedString.append(item.attributedString(with: stylesheet))
            attributedString.append(itemAttributedString)
        }

        return attributedString
    }
}
