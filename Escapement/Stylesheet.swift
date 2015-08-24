//
//  Stylesheet.swift
//  HodinkeeMobile
//
//  Created by Caleb Davenport on 7/29/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public struct Stylesheet {

    // MARK: - Properties

    var rules: [Rule]


    // MARK: - Subscripts

    public subscript(selector: String) -> [String: AnyObject] {
        get {
            var dictionary = [String: AnyObject]()

            for rule in rules.filter({ contains($0.selectors, selector) }) {
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

        var selectors: [String]

        var attributes: [String: AnyObject]

        // MARK: - Initializers

        public init(selectors: [String], attributes: [String: AnyObject]) {
            self.selectors = selectors
            self.attributes = attributes
        }

        public init(selector: String, attributes: [String: AnyObject]) {
            self.selectors = [ selector ]
            self.attributes = attributes
        }
    }
}
