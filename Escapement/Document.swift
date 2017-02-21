//
//  Document.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public struct Document {
    var paragraphs: [Paragraph]
}

extension Document {
    public func makeJSON() -> [Any] {
        return paragraphs.map({ $0.makeJSON() })
    }

    public init?(json: [Any]) {
        self.paragraphs = json.flatMap({ $0 as? [String: Any] }).flatMap(Paragraph.init)
    }
}

extension Document {
    public func attributedString(with stylesheet: Stylesheet) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: "")

        for (index, paragraph) in paragraphs.enumerated() {
            if index != 0 {
                mutableAttributedString.append(NSAttributedString(string: "\n"))
            }
            mutableAttributedString.append(paragraph.attributedString(with: stylesheet))
        }

        return NSAttributedString(attributedString: mutableAttributedString)
    }

    @available(*, deprecated, renamed: "attributedString(with:)")
    public func attributedString(stylesheet: Stylesheet) -> NSAttributedString {
        return attributedString(with: stylesheet)
    }
}

extension Document: Equatable {
    public static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.paragraphs == rhs.paragraphs
    }
}

@available(*, unavailable, message: "Use Document(json:) instead.")
typealias DocumentDecoder = Void

@available(*, unavailable, message: "Use Document.makeJSON() instead.")
typealias DocumentEncoder = Void
