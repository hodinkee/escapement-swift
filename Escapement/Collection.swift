//
//  Document.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension Collection where Iterator.Element: Element {
    public func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: "")

        for (index, element) in enumerated() {
            if index != 0 {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
            }
            mutableAttributedString.append(element.attributedString(with: stylesheet))
        }

        return NSAttributedString(attributedString: mutableAttributedString)
    }
}
