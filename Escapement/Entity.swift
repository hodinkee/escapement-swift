//
//  Entity.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public struct Entity {

    // MARK: - Properties

    public var tag: String

    public var range: Range<Int>

    public var attributes: [String: String]?


    // MARK: - Initializers

    public init(tag: String, range: Range<Int>, attributes: [String: String]? = nil) {
        self.tag = tag
        self.range = range
        self.attributes = attributes
    }
}

extension Entity {
    var href: URL? {
        if tag == "a" {
            return attributes?["href"].flatMap(URL.init)
        }
        return nil
    }

    func makeJSON() -> [String: Any] {
        var dictionary = [String: Any]()
        dictionary["html_tag"] = tag
        dictionary["position"] = [range.lowerBound, range.upperBound]
        dictionary["attributes"] = attributes
        return dictionary
    }

    init?(json: [String: Any]) {
        guard let tag = json["html_tag"] as? String else {
            return nil
        }
        self.tag = tag

        guard let positions = json["position"] as? [Int], positions.count == 2 else {
            return nil
        }
        self.range = positions[0]..<positions[1]

        self.attributes = json["attributes"] as? [String: String]
    }
}

extension Entity: Equatable {
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.tag == rhs.tag
            && lhs.range == rhs.range
            && lhs.href == rhs.href
    }
}
