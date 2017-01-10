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
    var range: Range<Int>
    private var attributes: [String: AnyObject]?
}

extension Entity {
    var href: NSURL? {
        if tag == "a" {
            return (attributes?["href"] as? String).flatMap({ NSURL(string: $0) })
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
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard let
            tag = JSON["html_tag"]?.stringValue,
            range = JSON["position"]?.decode(PositionDecoder)
        else {
            return nil
        }
        let attributes = JSON["attributes"]?.dictionaryValue
        return Entity(tag: tag, range: range, attributes: attributes)
    }
}


// MARK: - PositionDecoder

private struct PositionDecoder: DecoderType {
    static func decode(JSON: Alexander.JSON) -> Range<Int>? {
        guard let array = JSON.object as? [Int] where array.count == 2 else {
            return nil
        }
        return array[0]..<array[1]
    }
}


// MARK: - EntityEncoder

struct EntityEncoder: EncoderType {
    static func encode(_ value: Entity) -> Any {
        var dictionary = [String: AnyObject]()

        dictionary["html_tag"] = value.tag
        dictionary["position"] = [ value.range.startIndex, value.range.endIndex ]
        dictionary["attributes"] = value.attributes

        return dictionary
    }
}
