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


// MARK: - EncoderType

public struct DocumentEncoder: EncoderType {
    public typealias Value = Document
    public static func encode(value: Value) -> JSON {
        return JSON(object: ParagraphEncoder.encode(value.paragraphs).object)
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

// TODO: Switch to the Alexander implementation of Array.encode().
extension EncoderType {
    public static func encode<S: SequenceType where S.Generator.Element == Value>(sequence: S) -> JSON {
        return JSON(object: sequence.map({ encode($0).object }))
    }
}
