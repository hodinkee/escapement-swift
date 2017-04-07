//
//  Element.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol ElementProtocol {

    /// Ask the receiver to make an attributed string representation of itself.
    ///
    /// - parameter stylesheet: The stylesheet to apply to the returned
    ///     attributed string.
    ///
    /// - returns: An attributed string representation of the receiver.
    func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString
}

extension ElementProtocol {

    @available(*, deprecated, renamed: "makeAttributedString(stylesheet:)")
    func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        return makeAttributedString(stylesheet: stylesheet)
    }
}
