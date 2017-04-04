//
//  EscapementTests.swift
//  Escapement
//
//  Created by Caleb Davenport on 8/24/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import XCTest
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
            NSFontAttributeName: regularFont]

        let boldAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            NSFontAttributeName: boldFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "bold", attributes: boldAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: regularFont]

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
            NSFontAttributeName: regularFont]

        let boldAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            NSFontAttributeName: boldFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "bold", attributes: boldAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: regularFont]

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
            NSFontAttributeName: regularFont]

        let italicAttributes: [String: Any] = [
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: italicFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "italic", attributes: italicAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: regularFont]

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
            NSFontAttributeName: regularFont]

        let italicAttributes: [String: Any] = [
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: italicFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "italic", attributes: italicAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: regularAttributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: regularFont]

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

        let linkAttributes: [String: Any] = [
            NSLinkAttributeName: link]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: nil))
        expected.append(NSAttributedString(string: "link", attributes: linkAttributes))
        expected.append(NSAttributedString(string: ".", attributes: nil))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testStrikethroughTag() {
        guard let document = makeDocument(name: "test_strikethrough_tag") else {
            XCTFail("Missing document.")
            return
        }

        let strikethroughAttributes: [String: Any] = [
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: nil))
        expected.append(NSAttributedString(string: "struck-out", attributes: strikethroughAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: nil))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testDeleteTag() {
        guard let document = makeDocument(name: "test_delete_tag") else {
            XCTFail("Missing document.")
            return
        }

        let strikethroughAttributes: [String: Any] = [
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has a ", attributes: nil))
        expected.append(NSAttributedString(string: "struck-out", attributes: strikethroughAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: nil))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testUnderlineTag() {
        guard let document = makeDocument(name: "test_underline_tag") else {
            XCTFail("Missing document.")
            return
        }

        let underlineAttributes: [String: Any] = [
            NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This text has an ", attributes: nil))
        expected.append(NSAttributedString(string: "underlined", attributes: underlineAttributes))
        expected.append(NSAttributedString(string: " word.", attributes: nil))

        let stylesheet = Stylesheet()

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testDocumentMultipleParagraphs() {
        guard let document = makeDocument(name: "test_multiple_paragraphs") else {
            XCTFail("Missing document.")
            return
        }

        guard let font = UIFont(name: "HelveticaNeue", size: 18) else {
            XCTFail("Missing font.")
            return
        }

        let attributes: [String: Any] = [
            NSFontAttributeName: font]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "This is paragraph one.", attributes: attributes))
        expected.append(NSAttributedString(string: "\n"))
        expected.append(NSAttributedString(string: "This is paragraph two.", attributes: attributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: font]

        XCTAssertEqual(expected, document.attributedString(with: stylesheet))
    }

    func testOverlappingBoldEmphasisTags() {
        guard let document = makeDocument(name: "test_overlapping_strong_emphasis_tags") else {
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

        guard let italicFont = UIFont(name: "HelveticaNeue-Italic", size: 18) else {
            XCTFail("Missing italic font.")
            return
        }

        guard let boldItalicFont = UIFont(name: "HelveticaNeue-BoldItalic", size: 18) else {
            XCTFail("Missing bold italic font.")
            return
        }

        let regularAttributes: [String: Any] = [
            NSFontAttributeName: regularFont]

        let boldAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            NSFontAttributeName: boldFont]

        let italicAttributes: [String: Any] = [
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: italicFont]

        let boldItalicAttributes: [String: Any] = [
            StringAttributeName.escapementBold: true,
            StringAttributeName.escapementItalic: true,
            NSFontAttributeName: boldItalicFont]

        let expected = NSMutableAttributedString()
        expected.append(NSAttributedString(string: "Here ", attributes: regularAttributes))
        expected.append(NSAttributedString(string: "is ", attributes: boldAttributes))
        expected.append(NSAttributedString(string: "some", attributes: boldItalicAttributes))
        expected.append(NSAttributedString(string: " text", attributes: italicAttributes))
        expected.append(NSAttributedString(string: ".", attributes: regularAttributes))

        var stylesheet = Stylesheet()
        stylesheet["*"] = [NSFontAttributeName: regularFont]

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

    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else {
        return nil
    }

    return (json as? [Any]).flatMap(Document.init)
}
