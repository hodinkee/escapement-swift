//
//  Entity.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

struct Entity {

    // MARK: - Properties

    let tag: String

    let range: Range<Int>

    fileprivate let attributes: [String: Any]?

    var href: URL? {
        if tag == "a" {
            return (attributes?["href"] as? String).flatMap(URL.init)
        }
        return nil
    }
}

extension Entity {
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

        self.attributes = json["attributes"] as? [String: Any]
    }
}

extension Entity: Equatable {
    static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.tag == rhs.tag
            && lhs.range == rhs.range
            && lhs.href == rhs.href
    }
}
