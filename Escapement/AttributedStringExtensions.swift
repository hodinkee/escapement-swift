//
//  AttributedStringExtensions.swift
//  HodinkeeMobile
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension NSAttributedString {
    var attributesWithRanges: [([String: AnyObject], NSRange)] {
        var array = [([String: AnyObject], NSRange)]()

        let block: ([NSObject: AnyObject]?, NSRange, UnsafeMutablePointer<ObjCBool>) -> () = { attributes, range, _ in
            if let dictionary = attributes as? [String: AnyObject] {
                array.append((dictionary, range))
            }
        }
        enumerateAttributesInRange(NSMakeRange(0, length), options: nil, usingBlock: block)

        return array
    }
}
