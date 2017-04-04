//
//  ListTests.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

import XCTest
@testable import Escapement

final class ListTests: XCTestCase {
    func testOrderedList() {
        let stylesheet = Stylesheet()

        let subitems = [
            Paragraph(text: "Sub-Paragraph 1"),
            Paragraph(text: "Sub-Paragraph 2"),
        ]

        let items: [Element] = [
            Paragraph(text: "Paragraph 1"),
            UnorderedList(items: subitems),
            Paragraph(text: "Paragraph 2")
        ]

        let list = OrderedList(items: items)
        print(list.attributedString(with: stylesheet))
    }
}
