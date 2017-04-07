//
//  Collection+MakeAttributedString.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension Collection where Iterator.Element: ElementProtocol {

    /// Make an attributed string by calling `makeAttributedString(stylesheet:)`
    /// on all items and joining the resuls with new lines.
    ///
    /// - parameter stylesheet: The stylesheet to pass to every call to
    ///     `attributedString(with:)`.
    ///
    /// - returns: An attributed string representation of the elements.
    public func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString {
        if isEmpty {
            return NSAttributedString()
        }

        let mutableAttributedString = NSMutableAttributedString()

        for (index, element) in enumerated() {
            if index > 0 {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
            }
            mutableAttributedString.append(element.makeAttributedString(stylesheet: stylesheet))
        }

        return NSAttributedString(attributedString: mutableAttributedString)
    }
}
