//
//  Entity.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public protocol Entity {
    var tag: String { get }

    var range: Range<Int> { get }

    var attributes: [String: String] { get }
}

extension Entity {
    var selector: Stylesheet.Selector {
        return Stylesheet.Selector(tag)
    }
}
