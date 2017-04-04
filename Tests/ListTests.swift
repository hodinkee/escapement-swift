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
        var stylesheet = Stylesheet()
        stylesheet["*"] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16)
        ]
        stylesheet["ol"] = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
        ]

        let subitems = [
            Paragraph(text: "Sub-Paragraph 1"),
            Paragraph(text: "Sub-Paragraph 2"),
        ]

        let items: [Element] = [
            Paragraph(text: "Paragraph 1"),
            OrderedList(items: subitems),
            Paragraph(text: "Paragraph 2")
        ]

        let actual = OrderedList(items: items).attributedString(with: stylesheet)

        let expectedIndexAttributes: [String: Any] = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
        ]

        let expectedItemAttributes: [String: Any] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16),
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
        ]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "1.", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Paragraph 1", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "\t"))
        expected.append(NSAttributedString(string: "1.", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Sub-Paragraph 1", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "\t"))
        expected.append(NSAttributedString(string: "2.", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Sub-Paragraph 2", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "2.", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Paragraph 2", attributes: expectedItemAttributes))

        XCTAssertEqual(expected, actual)
    }

    func testUnorderedList() {
        var stylesheet = Stylesheet()
        stylesheet["*"] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16)
        ]
        stylesheet["ul"] = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
        ]

        let subitems = [
            Paragraph(text: "Sub-Paragraph 1"),
            Paragraph(text: "Sub-Paragraph 2"),
        ]

        let items: [Element] = [
            Paragraph(text: "Paragraph 1"),
            UnorderedList(items: subitems),
            Paragraph(text: "Paragraph 2")
        ]

        let actual = UnorderedList(items: items).attributedString(with: stylesheet)

        let expectedIndexAttributes: [String: Any] = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
        ]

        let expectedItemAttributes: [String: Any] = [
            NSFontAttributeName: UIFont.systemFont(ofSize: 16),
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
        ]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "\u{2022}", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Paragraph 1", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "\t"))
        expected.append(NSAttributedString(string: "\u{2022}", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Sub-Paragraph 1", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "\t"))
        expected.append(NSAttributedString(string: "\u{2022}", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Sub-Paragraph 2", attributes: expectedItemAttributes))
        expected.append(NSAttributedString(string: "\n"))

        expected.append(NSAttributedString(string: "\u{2022}", attributes: expectedIndexAttributes))
        expected.append(NSAttributedString(string: " "))
        expected.append(NSAttributedString(string: "Paragraph 2", attributes: expectedItemAttributes))
        
        XCTAssertEqual(expected, actual)
    }
}
