//
//  Paragraph.swift
//  HodinkeeMobile
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Constants

private let BoldTagAttributeName = "com.hodinkee.Escapement.BoldTag"
private let ItalicTagAttributeName = "com.hodinkee.Escapement.ItalicTag"


// MARK: - Types

struct Paragraph: AttributedStringConvertible {
    var text: String
    var entities: [Entity]
}


// MARK: - Equatable

extension Paragraph: Equatable {}

func ==(lhs: Paragraph, rhs: Paragraph) -> Bool {
    return lhs.text == rhs.text && lhs.entities == rhs.entities
}


// MARK: - JSONDecodable

extension Paragraph: JSONDecodable {
    static func decode(JSON: Alexander.JSON) -> Paragraph? {
        if
            let text = JSON["text"]?.string,
            let entities = JSON["entities"]?.decodeArray(Entity.self) {
                return Paragraph(text: text, entities: entities)
        }
        return nil
    }
}


// MARK: - JSONEncodable

extension Paragraph: JSONEncodable {
    var JSON: Alexander.JSON {
        return Alexander.JSON(object: [
            "text": text,
            "entities": entities.map({ $0.JSON.object })
        ])
    }
}


// MARK: - AttributedStringConvertible

extension Paragraph: AttributedStringConvertible {
    func attributedStringWithStyleSheet(stylesheet: Stylesheet) -> NSAttributedString {
        let baseFont = stylesheet["*"][NSFontAttributeName] as? UIFont ?? UIFont.systemFontOfSize(UIFont.systemFontSize())

        var baseAttributes = stylesheet["*"]
        baseAttributes[BoldTagAttributeName] = false
        baseAttributes[ItalicTagAttributeName] = false
        baseAttributes[NSFontAttributeName] = baseFont

        let string = NSMutableAttributedString(string: text, attributes: baseAttributes)

        for entity in entities {
            let range = entity.NSRange

            string.addAttributes(stylesheet[entity.tag], range: range)

            switch entity.tag {
            case "a":
                if let href = entity.href {
                    string.addAttribute(NSLinkAttributeName, value: href, range: range)
                }
            case "strong", "b":
                string.addAttribute(BoldTagAttributeName, value: true, range: range)
            case "em", "i":
                string.addAttribute(ItalicTagAttributeName, value: true, range: range)
            case "s", "del":
                string.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.StyleSingle.rawValue, range: range)
            default:
                ()
            }
        }

        let baseFontDescriptor = baseFont.fontDescriptor()
        let fontsWithRanges: [(UIFontDescriptor, NSRange)] = string.attributesWithRanges.map({ attributes, range in
            var fontDescriptor: UIFontDescriptor = baseFontDescriptor

            if attributes[BoldTagAttributeName] as? Bool ?? false {
                fontDescriptor = fontDescriptor.boldFontDescriptor
            }

            if attributes[ItalicTagAttributeName] as? Bool ?? false {
                fontDescriptor = fontDescriptor.italicFontDescriptor
            }

            return (fontDescriptor, range)
        })
        for (font, range) in fontsWithRanges {
            string.addAttribute(NSFontAttributeName, value: UIFont(descriptor: font, size: baseFont.pointSize), range: range)
        }

        return NSAttributedString(attributedString: string)
    }
}
