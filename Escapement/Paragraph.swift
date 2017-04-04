//
//  Paragraph.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public struct Paragraph {

    // MARK: - Properties

    public var text: String

    public var entities: [Entity]


    // MARK: - Initializers

    public init(text: String, entities: [Entity] = []) {
        self.text = text
        self.entities = entities
    }
}

extension Paragraph {
    func makeJSON() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["text"] = text
        dictionary["entities"] = entities.map({ $0.makeJSON() })
        return dictionary
    }

    init?(json: [String: Any]) {
        guard let text = json["text"] as? String else {
            return nil
        }
        self.text = text

        guard let entities = json["entities"] as? [Any] else {
            return nil
        }
        self.entities = entities.flatMap({ $0 as? [String: Any] }).flatMap(Entity.init)
    }
}

extension Paragraph {
    func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        var attributes = stylesheet["*"]
        attributes[StringAttributeName.escapementBold] = false
        attributes[StringAttributeName.escapementItalic] = false

        let string = NSMutableAttributedString(string: text, attributes: attributes)

        for entity in entities {
            let range = NSRange(entity.range)

            switch entity.tag {
            case "a":
                if let URL = entity.href {
                    string.addAttribute(NSLinkAttributeName, value: URL, range: range)
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

            string.addAttributes(stylesheet[entity.tag], range: range)
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

extension Paragraph: Equatable {
    public static func == (lhs: Paragraph, rhs: Paragraph) -> Bool {
        return lhs.text == rhs.text && lhs.entities == rhs.entities
    }
}
