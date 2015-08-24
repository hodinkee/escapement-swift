//
//  AttributedStringConvertible.swift
//  HodinkeeMobile
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public protocol AttributedStringConvertible {
    func attributedStringWithStyleSheet(stylesheet: Stylesheet) -> NSAttributedString
}
