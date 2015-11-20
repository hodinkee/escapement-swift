//
//  Entity.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Types

struct Entity {
    var tag: String
    var range: Range<Int>
    private var attributes: [String: AnyObject]?

    var NSRange: Foundation.NSRange {
        return NSMakeRange(range.startIndex, range.endIndex - range.startIndex)
    }

    var href: NSURL? {
        if tag == "a" {
            return (attributes?["href"] as? String).flatMap({ NSURL(string: $0) })
        }
        return nil
    }
}


// MARK: - Equatable

extension Entity: Equatable {}

func ==(lhs: Entity, rhs: Entity) -> Bool {
    return lhs.tag == rhs.tag
        && lhs.range == rhs.range
        && lhs.href == rhs.href
}


// MARK: - DecoderType

struct EntityDecoder: DecoderType {
    typealias Value = Entity
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard
            let tag = JSON["html_tag"]?.stringValue,
            let range = JSON["position"]?.decode(PositionDecoder)
        else {
            return nil
        }
        let attributes = JSON["attributes"]?.object as? [String: AnyObject]
        return Entity(tag: tag, range: range, attributes: attributes)
    }
}

private struct PositionDecoder: DecoderType {
    typealias Value = Range<Int>
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard let array = JSON.object as? [Int] where array.count == 2 else {
            return nil
        }
        return array[0]..<array[1]
    }
}


// MARK: - JSONEncodable

extension Entity: JSONEncodable {
    var JSON: Alexander.JSON {
        return Alexander.JSON(object: [
            "html_tag": tag,
            "position": [ range.startIndex, range.endIndex ],
            "attributes": attributes ?? NSNull()
        ])
    }
}
