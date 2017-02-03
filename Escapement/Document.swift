//
//  Document.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Document

public struct Document {
    var paragraphs: [Paragraph]
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


// MARK: - DocumentDecoder

public struct DocumentDecoder: DecoderType {
    public static func decode(_ json: JSON) -> Document? {
        guard let paragraphs = json.decodeArray(ParagraphDecoder.self) else {
            return nil
        }
        return Document(paragraphs: paragraphs)
    }
}


// MARK: - DocumentEncoder

public struct DocumentEncoder: EncoderType {
    public static func encode(_ document: Document) -> Any {
        return ParagraphEncoder.encodeSequence(document.paragraphs)
    }
}
