//
//  Element.swift
//  Escapement
//
//  Created by Jonathan Baker on 4/4/17.
//  Copyright © 2017 Hodinkee. All rights reserved.
//

public protocol Element {
    func attributedString(with stylesheet: Stylesheet) -> NSAttributedString
}
