//
//  Entity.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Entity

struct Entity {

    // MARK: - Properties

    let tag: String

    let range: Range<Int>

    fileprivate let attributes: [String: Any]?

    var href: URL? {
        if tag == "a" {
            return (attributes?["href"] as? String).flatMap({ URL(string: $0) })
        }
        return nil
    }
}

extension Entity: Equatable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.tag == rhs.tag
            && lhs.range == rhs.range
            && lhs.href == rhs.href
    }
}


// MARK: - EntityDecoder

struct EntityDecoder: DecoderType {
    static func decode(_ json: JSON) -> Entity? {
        guard
            let tag = json["html_tag"]?.stringValue,
            let range = json["position"]?.decode(PositionDecoder.self)
        else {
            return nil
        }

        let attributes = json["attributes"]?.dictionaryValue

        return Entity(tag: tag, range: range, attributes: attributes)
    }
}


// MARK: - PositionDecoder

private struct PositionDecoder: DecoderType {
    static func decode(_ json: JSON) -> Range<Int>? {
        guard
            let array = json.object as? [Int],
            array.count == 2
        else {
            return nil
        }

        return array[0]..<array[1]
    }
}


// MARK: - EntityEncoder

struct EntityEncoder: EncoderType {
    static func encode(_ entity: Entity) -> Any {
        var dictionary = [String: Any]()

        dictionary["html_tag"] = entity.tag
        dictionary["position"] = [entity.range.lowerBound, entity.range.upperBound]
        dictionary["attributes"] = entity.attributes

        return dictionary
    }
}
