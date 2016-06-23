//
//  AttributedStringConvertible.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

protocol AttributedStringConvertible {
    func attributedStringWithStylesheet(stylesheet: Stylesheet) -> NSAttributedString
}
