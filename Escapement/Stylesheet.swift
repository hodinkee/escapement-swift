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

    public subscript(selector: String) -> [String: Any] {
        get {
            var dictionary = [String: Any]()

            rules.lazy.filter({ $0.selectors.contains("*") }).forEach({
                $0.attributes.forEach({ dictionary[$0] = $1 })
            })

            if selector == "*" {
                return dictionary
            }

            rules.forEach({
                $0.attributes.forEach({ dictionary[$0] = $1 })
            })

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

        var selectors: Set<String>

        var attributes: [String: Any]
        

        // MARK: - Initializers

        public init(selectors: Set<String>, attributes: [String: Any]) {
            self.selectors = selectors
            self.attributes = attributes
        }

        public init(selector: String, attributes: [String: Any]) {
            self.selectors = [selector]
            self.attributes = attributes
        }
    }
}
