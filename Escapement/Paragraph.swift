//
//  Paragraph.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Constants

private let BoldTagAttributeName = "com.hodinkee.Escapement.BoldTag"
private let ItalicTagAttributeName = "com.hodinkee.Escapement.ItalicTag"


// MARK: - Types

struct Paragraph {
    var text: String
    var entities: [Entity]
}


// MARK: - Equatable

extension Paragraph: Equatable {}

func ==(lhs: Paragraph, rhs: Paragraph) -> Bool {
    return lhs.text == rhs.text && lhs.entities == rhs.entities
}


// MARK: - DecoderType

struct ParagraphDecoder: DecoderType {
    static func decode(JSON: Alexander.JSON) -> Paragraph? {
        guard let
            text = JSON["text"]?.stringValue,
            entities = JSON["entities"]?.decodeArray(EntityDecoder)
        else {
            return nil
        }
        return Paragraph(text: text, entities: entities)
    }
}


// MARK: - EncoderType

struct ParagraphEncoder: EncoderType {
    static func encode(value: Paragraph) -> AnyObject {
        return [
            "text": value.text,
            "entities": EntityEncoder.encodeSequence(value.entities)
        ]
    }
}


// MARK: - AttributedStringConvertible

extension Paragraph {
    func attributedString(stylesheet stylesheet: Stylesheet) -> NSAttributedString {
        var attributes = stylesheet["*"]
        attributes[BoldTagAttributeName] = false
        attributes[ItalicTagAttributeName] = false

        let string = NSMutableAttributedString(string: text, attributes: attributes)

        for entity in entities {
            let range = NSRange(entity.range)

            switch entity.tag {
            case "a":
                if let URL = entity.href {
                    string.addAttribute(NSLinkAttributeName, value: URL, range: range)
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

            string.addAttributes(stylesheet[entity.tag], range: range)
        }

        string.enumerateAttributesInRange(NSRange(0..<string.length), options: [], usingBlock: { attributes, range, _ in
            var descriptor = (attributes[NSFontAttributeName] as? UIFont)?.fontDescriptor()

            if attributes[BoldTagAttributeName] as? Bool ?? false {
                descriptor = descriptor?.boldFontDescriptor
            }

            if attributes[ItalicTagAttributeName] as? Bool ?? false {
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
