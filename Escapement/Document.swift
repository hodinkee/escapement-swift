//
//  Document.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/16/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Alexander

// MARK: - Types

public struct Document {
    var paragraphs: [Paragraph]
}


// MARK: - Equatable

extension Document: Equatable {}

public func ==(lhs: Document, rhs: Document) -> Bool {
    return lhs.paragraphs == rhs.paragraphs
}


// MARK: - DecoderType

public struct DocumentDecoder: DecoderType {
    public typealias Value = Document
    public static func decode(JSON: Alexander.JSON) -> Value? {
        guard let paragraphs = JSON.decodeArray(ParagraphDecoder) else {
            return nil
        }
        return Document(paragraphs: paragraphs)
    }
}


// MARK: - JSONEncodable

extension Document: JSONEncodable {
    public var JSON: Alexander.JSON {
        return Alexander.JSON(object: paragraphs.map({ ParagraphEncoder.encode($0).object }))
    }
}


// MARK: - AttributedStringConvertible

extension Document: AttributedStringConvertible {
    public func attributedStringWithStylesheet(stylesheet: Stylesheet) -> NSAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: "")

        for (index, paragraph) in paragraphs.enumerate() {
            if index != 0 {
                mutableAttributedString.appendAttributedString(NSAttributedString(string: "\n"))
            }
            mutableAttributedString.appendAttributedString(paragraph.attributedStringWithStylesheet(stylesheet))
        }

        return NSAttributedString(attributedString: mutableAttributedString)
    }
}
