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

    func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        return paragraphs.makeAttributedString(stylesheet)
    }
}

struct Paragraph: Escapement.Paragraph {
    var text: String

    var entities: [Escapement.Entity]

    init(text: String, entities: [Escapement.Entity] = []) {
        self.text = text
        self.entities = entities
    }
}

struct OrderedList: Escapement.List {
    var items: [Escapement.Element]

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        return NSAttributedString(string: "\(index).", attributes: stylesheet["ol"])
    }
}

struct UnorderedList: Escapement.List {
    var items: [Escapement.Element]

    func attributedIndex(with stylesheet: Stylesheet, index: Int, depth: Int) -> NSAttributedString {
        return NSAttributedString(string: "\u{2022}", attributes: stylesheet["ul"])
    }
}

struct Entity: Escapement.Entity {
    var tag: String

    var range: Range<Int>

    var attributes: [String: String]
}

extension Document {
    init?(json: [Any]) {
        self.paragraphs = json.flatMap({ $0 as? [String: Any] }).flatMap(Paragraph.init)
    }

    func makeJSON() -> [Any] {
        return paragraphs.map({ $0.makeJSON() })
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

    func makeJSON() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["text"] = text
        dictionary["entities"] = entities.flatMap({ $0 as? Entity }).map({ $0.makeJSON() })
        return dictionary
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

    func makeJSON() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["html_tag"] = tag
        dictionary["position"] = [range.lowerBound, range.upperBound]
        dictionary["attributes"] = attributes
        return dictionary
    }
}
