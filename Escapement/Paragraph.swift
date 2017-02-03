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


// MARK: - Paragraph

struct Paragraph {
    var text: String
    var entities: [Entity]
}

extension Paragraph {
    func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
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
                string.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue, range: range)
            default:
                ()
            }

            string.addAttributes(stylesheet[entity.tag], range: range)
        }

        string.enumerateAttributes(in: NSRange(0..<string.length), options: [], using: { attributes, range, _ in
            var descriptor = (attributes[NSFontAttributeName] as? UIFont)?.fontDescriptor

            if let bold = attributes[BoldTagAttributeName] as? Bool, bold {
                descriptor = descriptor?.boldFontDescriptor
            }

            if let italic = attributes[ItalicTagAttributeName] as? Bool, italic {
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

extension Paragraph: Equatable {
    static func == (lhs: Paragraph, rhs: Paragraph) -> Bool {
        return lhs.text == rhs.text && lhs.entities == rhs.entities
    }
}


// MARK: - ParagraphDecoder

struct ParagraphDecoder: DecoderType {
    static func decode(_ json: JSON) -> Paragraph? {
        guard
            let text = json["text"]?.stringValue,
            let entities = json["entities"]?.decodeArray(EntityDecoder.self)
        else {
            return nil
        }
        return Paragraph(text: text, entities: entities)
    }
}


// MARK: - ParagraphEncoder

struct ParagraphEncoder: EncoderType {
    static func encode(_ paragraph: Paragraph) -> Any {
        return [
            "text": paragraph.text,
            "entities": EntityEncoder.encodeSequence(paragraph.entities)
        ]
    }
}
