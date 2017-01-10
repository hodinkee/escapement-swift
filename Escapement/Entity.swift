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
    var tag: String
    var range: CountableRange<Int>
    private var attributes: [String: AnyObject]?
}

extension Entity {
    var href: URL? {
        if tag == "a" {
            return (attributes?["href"] as? String).flatMap({ URL(string: $0) })
        }
        return nil
    }
}

extension Entity: Equatable {}

func ==(lhs: Entity, rhs: Entity) -> Bool {
    return lhs.tag == rhs.tag
        && lhs.range == rhs.range
        && lhs.href == rhs.href
}


// MARK: - EntityDecoder

struct EntityDecoder: DecoderType {
    typealias Value = Entity
    static func decode(_ JSON: Alexander.JSON) -> Value? {
        guard let
            tag = JSON["html_tag"]?.stringValue,
            let range = JSON["position"]?.decode(PositionDecoder.self)
        else {
            return nil
        }
        let attributes = JSON["attributes"]?.dictionaryValue
        return Entity(tag: tag, range: range, attributes: attributes as [String : AnyObject]?)
    }
}


// MARK: - PositionDecoder

private struct PositionDecoder: DecoderType {
    static func decode(_ JSON: Alexander.JSON) -> CountableRange<Int>? {
        guard let array = JSON.object as? [Int], array.count == 2 else {
            return nil
        }
        return array[0]..<array[1]
    }
}


// MARK: - EntityEncoder

struct EntityEncoder: EncoderType {
    static func encode(_ value: Entity) -> Any {
        var dictionary = [String: Any]()

        dictionary["html_tag"] = value.tag as AnyObject?
        dictionary["position"] = [value.range.lowerBound, value.range.upperBound]
        dictionary["attributes"] = value.attributes as AnyObject?

        return dictionary as AnyObject
    }
}
