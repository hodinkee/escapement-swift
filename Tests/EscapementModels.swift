//
//  Escapement+JSON.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

@testable import Escapement

struct Document {
    var paragraphs: [Paragraph]

    func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString {
        return paragraphs.makeAttributedString(stylesheet: stylesheet)
    }
}

struct Paragraph: Escapement.ParagraphProtocol {
    var text: String

    var entities: [Escapement.EntityProtocol]

    init(text: String, entities: [Escapement.EntityProtocol] = []) {
        self.text = text
        self.entities = entities
    }
}

struct OrderedList: Escapement.ListProtocol {
    var items: [Escapement.ElementProtocol]

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        return NSAttributedString(string: "\(index).", attributes: stylesheet["ol"])
    }
}

struct UnorderedList: Escapement.ListProtocol {
    var items: [Escapement.ElementProtocol]

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        let bullet: String = {
            switch depth {
            case 1:
                return "\u{25E6}"
            default:
                return "\u{2022}"
            }
        }()
        return NSAttributedString(string: bullet, attributes: stylesheet["ul"])
    }
}

struct Entity: Escapement.EntityProtocol {
    var tag: String

    var range: Range<Int>

    var attributes: [String: String]
}

extension Document {
    init?(json: [Any]) {
        self.paragraphs = json.flatMap({ $0 as? [String: Any] }).flatMap(Paragraph.init)
    }
}

extension Paragraph {
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

extension Entity {
    init?(json: [String: Any]) {
        guard let tag = json["html_tag"] as? String else {
            return nil
        }
        self.tag = tag

        guard let positions = json["position"] as? [Int], positions.count == 2 else {
            return nil
        }
        self.range = positions[0]..<positions[1]

        self.attributes = json["attributes"] as? [String: String] ?? [:]
    }
}
