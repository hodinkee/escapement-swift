//
//  AttributedStringExtensions.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension NSAttributedString {
    var attributesWithRanges: [([String: AnyObject], NSRange)] {
        var array = [([String: AnyObject], NSRange)]()
        enumerateAttributesInRange(NSMakeRange(0, length), options: [], usingBlock: { attributes, range, _ in
            array.append((attributes, range))
        })
        return array
    }
}
