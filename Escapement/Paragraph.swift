//
//  Paragraph.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public protocol ParagraphProtocol: ElementProtocol {
    var text: String { get }

    var entities: [Entity] { get }
}

extension ParagraphProtocol {
    public func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString {
        let string = NSMutableAttributedString(string: text, attributes: stylesheet.attributes(forSelector: "*"))

        for entity in entities {
            let range = NSRange(entity.range)

            switch entity.tag {
            case "a":
                if let url = entity.attributes["href"].flatMap(URL.init) {
                    string.addAttribute(NSLinkAttributeName, value: url, range: range)
                }
            case "strong", "b":
                string.addAttribute(StringAttributeName.escapementBold, value: true, range: range)
            case "em", "i":
                string.addAttribute(StringAttributeName.escapementItalic, value: true, range: range)
            case "s", "del":
                string.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
            case "u":
                string.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
            default:
                ()
            }

            string.addAttributes(stylesheet.attributes(forSelector: entity.tag), range: range)
        }

        string.enumerateAttributes(in: NSRange(0..<string.length), options: [], using: { attributes, range, _ in
            var descriptor = (attributes[NSFontAttributeName] as? UIFont)?.fontDescriptor

            if let bold = attributes[StringAttributeName.escapementBold] as? Bool, bold {
                descriptor = descriptor?.boldFontDescriptor
            }

            if let italic = attributes[StringAttributeName.escapementItalic] as? Bool, italic {
                descriptor = descriptor?.italicFontDescriptor
            }

            if let descriptor = descriptor {
                let font = UIFont(descriptor: descriptor, size: 0)
                string.addAttribute(NSFontAttributeName, value: font, range: range)
            }
        })

        return NSAttributedString(attributedString: string)
    }
}

public struct Paragraph: ParagraphProtocol {

    // MARK: - Properties

    public var text: String

    public var entities: [Entity]


    // MARK: - Initializers

    public init(text: String, entities: [Entity] = []) {
        self.text = text
        self.entities = entities
    }
}
