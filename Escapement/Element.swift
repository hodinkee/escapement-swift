//
//  Element.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public enum Element: Styleable {
    case paragraph(Paragraph)
    case orderedList(OrderedList)
    case unorderedList(UnorderedList)

    // MARK: - ElementProtocol

    public func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString {
        switch self {
        case .paragraph(let paragraph):
            return paragraph.makeAttributedString(stylesheet: stylesheet)
        case .orderedList(let orderedList):
            return orderedList.makeAttributedString(stylesheet: stylesheet)
        case .unorderedList(let unorderedList):
            return unorderedList.makeAttributedString(stylesheet: stylesheet)
        }
    }
}
