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

    public var attributes: [String: String]

    // MARK: - Initializers

    public init(tag: String, range: Range<Int>, attributes: [String: String] = [:]) {
        self.tag = tag
        self.range = range
        self.attributes = attributes
    }
}

extension Entity: Equatable {
    public static func == (lhs: Entity, rhs: Entity) -> Bool {
        return lhs.tag == rhs.tag
            && lhs.range == rhs.range
            && lhs.attributes == rhs.attributes
    }
}
