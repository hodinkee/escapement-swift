//
//  UIFontDescriptor.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/28/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension UIFontDescriptor {
    @nonobjc var boldFontDescriptor: UIFontDescriptor? {
        return withSymbolicTraits(symbolicTraits.union(.traitBold))
    }

    @nonobjc var italicFontDescriptor: UIFontDescriptor? {
        return withSymbolicTraits(symbolicTraits.union(.traitItalic))
    }
}
