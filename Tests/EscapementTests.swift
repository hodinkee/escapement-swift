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
            XCTFail("Failed to load test document."); return
        }

        let regularFont = UIFont(name: "HelveticaNeue", size: 18)!
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: "bold", attributes: [
            NSFontAttributeName: boldFont,
            StringAttributeName.escapementBold: true,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: " word.", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: [NSFontAttributeName: regularFont])])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStrongTag() {
        guard let document = makeDocument(name: "test_strong_tag") else {
            XCTFail("Failed to load test document."); return
        }

        let regularFont = UIFont(name: "HelveticaNeue", size: 18)!
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: "bold", attributes: [
            NSFontAttributeName: boldFont,
            StringAttributeName.escapementBold: true,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: " word.", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: [NSFontAttributeName: regularFont])])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testItalicTag() {
        guard let document = makeDocument(name: "test_italic_tag") else {
            XCTFail("Failed to load test document."); return
        }

        let regularFont = UIFont(name: "HelveticaNeue", size: 18)!
        let italicFont = UIFont(name: "HelveticaNeue-Italic", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: "italic", attributes: [
            NSFontAttributeName: italicFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: true]))
        expected.append(NSAttributedString(string: " word.", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: [NSFontAttributeName: regularFont])])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testEmphasisTag() {
        guard let document = makeDocument(name: "test_emphasis_tag") else {
            XCTFail("Failed to load test document."); return
        }

        let regularFont = UIFont(name: "HelveticaNeue", size: 18)!
        let italicFont = UIFont(name: "HelveticaNeue-Italic", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: "italic", attributes: [
            NSFontAttributeName: italicFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: true]))
        expected.append(NSAttributedString(string: " word.", attributes: [
            NSFontAttributeName: regularFont,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: [NSFontAttributeName: regularFont])])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testLinkTag() {
        guard let document = makeDocument(name: "test_link_tag") else {
            XCTFail("Failed to load test document."); return
        }

        let regularAttributes: [String: Any] = [
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]

        let linkAttributes: [String: Any]? = URL(string: "https://www.apple.com")
            .map({[
                NSLinkAttributeName: $0,
                StringAttributeName.escapementBold: false,
                StringAttributeName.escapementItalic: false]
            })
        XCTAssertNotNil(linkAttributes)

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "link", attributes: linkAttributes))
        expected.append(NSAttributedString(string: ".", attributes: regularAttributes))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStrikethroughTag() {
        guard let document = makeDocument(name: "test_strikethrough_tag") else {
            XCTFail("Failed to load test document."); return
        }

        let font = UIFont(name: "HelveticaNeue", size: 18)!

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: "struck-out", attributes: [
            NSFontAttributeName: font,
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))
        expected.append(NSAttributedString(string: " word.", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false]))

        let stylesheet = Stylesheet(rules: [
            Stylesheet.Rule(selector: "*", attributes: [NSFontAttributeName: font])])

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStylesheetSubscriptSetter() {
        guard let document = makeDocument(name: "test_plain") else {
            XCTFail("Failed to load test document."); return
        }

        let font = UIFont(name: "HelveticaNeue", size: 18)!

        let expected = NSAttributedString(string: "This is an span of plain text.", attributes: [
            NSFontAttributeName: font,
            StringAttributeName.escapementBold: false,
            StringAttributeName.escapementItalic: false
        ])

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: font]

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testDocumentMultipleParagraphs() {
        guard let document = makeDocument(name: "test_paragraphs") else {
            XCTFail("Failed to load test document."); return
        }

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

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
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
