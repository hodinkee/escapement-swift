//
//  FontDescriptorExtensions.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/28/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

extension UIFontDescriptor {
    var boldFontDescriptor: UIFontDescriptor? {
        return fontDescriptorWithSymbolicTraits(symbolicTraits.union(.TraitBold))
    }

    var italicFontDescriptor: UIFontDescriptor? {
        return fontDescriptorWithSymbolicTraits(symbolicTraits.union(.TraitItalic))
    }
}
