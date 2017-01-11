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
    public func attributedString(stylesheet: Stylesheet) -> NSAttributedString {
        return paragraphs.lazy
            .map({ $0.attributedString(stylesheet: stylesheet) })
            .joined(separator: { NSAttributedString(string: "\n") })
            .reduce(NSAttributedString(string: ""), +)
    }
}

extension Document: Equatable {
    public static func == (lhs: Document, rhs: Document) -> Bool {
        return lhs.paragraphs == rhs.paragraphs
    }
}


// MARK: - DocumentDecoder

public struct DocumentDecoder: DecoderType {
    public static func decode(_ json: Alexander.JSON) -> Document? {
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

extension Sequence {
    fileprivate func joined(separator: @escaping () -> Iterator.Element) -> AnySequence<Iterator.Element> {
        return AnySequence(sequence(state: (makeIterator(), false), next: { (state: inout (Iterator, Bool)) -> Iterator.Element? in
            defer { state.1 = !state.1 }
            return state.1 ? separator() : state.0.next()
        }))
    }
}

fileprivate func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
    let string = NSMutableAttributedString(attributedString: lhs)
    string.append(rhs)
    return string
}
