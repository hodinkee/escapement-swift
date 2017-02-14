//
//  EscapementTests.swift
//  Escapement
//
//  Created by Caleb Davenport on 8/24/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import XCTest
import Alexander
@testable import Escapement

final class EscapementTests: XCTestCase {
    func testBoldTag() {
        guard let document = makeDocument(name: "test_bold_tag") else {
            XCTFail("Missing document.")
            return
        }

        guard let regularFont = UIFont(name: "HelveticaNeue", size: 18) else {
            XCTFail("Missing regular font.")
            return
        }

        guard let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 18) else {
            XCTFail("Missing bold font.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: regularFont]

        let boldAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: boldFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "bold", attributes: boldAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheetAttributes = [NSFontAttributeName: regularFont]

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: stylesheetAttributes)])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStrongTag() {
        guard let document = makeDocument(name: "test_strong_tag") else {
            XCTFail("Missing document.")
            return
        }

        guard let regularFont = UIFont(name: "HelveticaNeue", size: 18) else {
            XCTFail("Missing regular font.")
            return
        }

        guard let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 18) else {
            XCTFail("Missing bold font.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: regularFont]

        let boldAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: boldFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "bold", attributes: boldAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheetAttributes = [NSFontAttributeName: regularFont]

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: stylesheetAttributes)])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testItalicTag() {
        guard let document = makeDocument(name: "test_italic_tag") else {
            XCTFail("Missing document.")
            return
        }

        guard let regularFont = UIFont(name: "HelveticaNeue", size: 18) else {
            XCTFail("Missing regular font.")
            return
        }

        guard let italicFont = UIFont(name: "HelveticaNeue-Italic", size: 18) else {
            XCTFail("Missing italic font.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: regularFont]

        let italicAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: italicFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "italic", attributes: italicAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheetAttributes = [NSFontAttributeName: regularFont]

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: stylesheetAttributes)])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testEmphasisTag() {
        guard let document = makeDocument(name: "test_emphasis_tag") else {
            XCTFail("Missing document.")
            return
        }

        guard let regularFont = UIFont(name: "HelveticaNeue", size: 18) else {
            XCTFail("Missing regular font.")
            return
        }

        guard let italicFont = UIFont(name: "HelveticaNeue-Italic", size: 18) else {
            XCTFail("Missing italic font.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSFontAttributeName: regularFont]

        let italicAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: italicFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "italic", attributes: italicAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheetAttributes = [NSFontAttributeName: regularFont]

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: stylesheetAttributes)])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testLinkTag() {
        guard let document = makeDocument(name: "test_link_tag") else {
            XCTFail("Missing document.")
            return
        }

        guard let link = URL(string: "https://www.apple.com") else {
            XCTFail("Invalid URL.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]

        let linkAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSLinkAttributeName: link]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "link", attributes: linkAttributes))
        expected.append(NSAttributedString(string: ".", attributes: regularAttributes))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStrikethroughTag() {
        guard let document = makeDocument(name: "test_strikethrough_tag") else {
            XCTFail("Missing document.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]

        let strikethroughAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "struck-out", attributes: strikethroughAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testDeleteTag() {
        guard let document = makeDocument(name: "test_delete_tag") else {
            XCTFail("Missing document.")
            return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]

        let strikethroughAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false,
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "struck-out", attributes: strikethroughAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStylesheetSubscriptSetter() {
        let document = makeDocument(name: "test_plain")
        XCTAssertNotNil(document)

        let font = UIFont(name: "HelveticaNeue", size: 18)!

        let expected = NSAttributedString(string: "This is an span of plain text.", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false
        ])

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: font]

        XCTAssertEqual(expected, document?.attributedString(with: stylesheet))
    }

    func testDocumentMultipleParagraphs() {
        let document = makeDocument(name: "test_paragraphs")
        XCTAssertNotNil(document)

        let font = UIFont(name: "HelveticaNeue", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This is paragraph one.", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false
        ]))
        expected.append(NSAttributedString(string: "\n"))
        expected.append(NSAttributedString(string: "This is paragraph two.", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false
        ]))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: font]

        XCTAssertEqual(expected, document?.attributedString(with: stylesheet))
    }

    func testDocumentEquatable() {
        let foo = makeDocument(name: "test_paragraphs")
        XCTAssertNotNil(foo)

        let bar = makeDocument(name: "test_paragraphs")
        XCTAssertNotNil(bar)

        XCTAssertEqual(foo, bar)

        let boldOne = makeDocument(name: "test_bold_tag")
        XCTAssertNotNil(boldOne)

        let boldTwo = makeDocument(name: "test_bold_tag")
        XCTAssertNotNil(boldTwo)

        XCTAssertEqual(boldOne, boldTwo)

        XCTAssertNotEqual(foo, boldTwo)
    }
}

func makeDocument(name: String) -> Document? {
    guard let url = Bundle(for: EscapementTests.self).url(forResource: name, withExtension: "json") else {
        return nil
    }

    guard let data = try? Data(contentsOf: url) else {
        return nil
    }

    guard let json = try? JSON(data: data) else {
        return nil
    }

    return DocumentDecoder.decode(json)
}
