//
//  Stylesheet.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/29/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public struct Stylesheet {

    // MARK: - Properties

    var rules: [Rule]


    // MARK: - Subscripts

    public subscript(selector: Selector) -> [String: Any] {
        get {
            var dictionary = [String: Any]()

            for rule in rules.filter({ $0.selectors.contains(selector) }) {
                for (key, value) in rule.attributes {
                    dictionary[key] = value
                }
            }

            return dictionary
        }
        set {
            rules.append(Rule(selector: selector, attributes: newValue))
        }
    }


    // MARK: - Initializers

    public init(rules: [Rule] = []) {
        self.rules = rules
    }
}

extension Stylesheet {
    public struct Rule {

        // MARK: - Properties

        var selectors: [Selector]

        var attributes: [String: Any]
        

        // MARK: - Initializers

        public init(selectors: [Selector], attributes: [String: Any]) {
            self.selectors = selectors
            self.attributes = attributes
        }

        public init(selector: Selector, attributes: [String: Any]) {
            self.selectors = [selector]
            self.attributes = attributes
        }
    }
}

extension Stylesheet {
    public struct Selector: RawRepresentable, ExpressibleByStringLiteral, Equatable {

        // MARK: - Properties

        public let rawValue: String


        // MARK: - Initializers

        public init(_ value: String) {
            self.rawValue = value.lowercased()
        }

        public init(rawValue: String) {
            self.init(rawValue)
        }

        public init(stringLiteral value: String) {
            self.init(value)
        }

        public init(unicodeScalarLiteral value: String) {
            self.init(value)
        }

        public init(extendedGraphemeClusterLiteral value: String) {
            self.init(value)
        }
    }
}
