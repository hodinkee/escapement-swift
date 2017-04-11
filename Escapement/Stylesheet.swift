//
//  Stylesheet.swift
//  Escapement
//
//  Created by Caleb Davenport on 7/29/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public protocol Styleable {
    /// Ask the receiver to make an attributed string representation of itself.
    ///
    /// - parameter stylesheet: The stylesheet to apply to the returned
    ///     attributed string.
    ///
    /// - returns: An attributed string representation of the receiver.
    func makeAttributedString(stylesheet: Stylesheet) -> NSAttributedString
}

public struct Stylesheet {

    // MARK: - Properties

    var rules: [String: [String: Any]] = [:]
    

    // MARK: - Subscripts

    @available(*, deprecated)
    public subscript(selector: String) -> [String: Any] {
        get {
            return attributes(forSelector: selector)
        }
        set {
            setAttributes(newValue, forSelectors: [selector])
        }
    }


    // MARK: - Initializers

    public init() {}


    // MARK: - Public

    public func attributes(forSelector selector: String) -> [String: Any] {
        var dictionary = [String: Any]()

        rules["*"]?.forEach({ dictionary[$0] = $1 })
        rules[selector]?.forEach({ dictionary[$0] = $1 })

        return dictionary
    }

    public mutating func addAttributes(_ attributes: [String: Any], forSelectors selectors: Set<String>) {
        selectors.forEach({
            addAttributes(attributes, forSelector: $0)
        })
    }

    public mutating func addAttributes(_ attributes: [String: Any], forSelector selector: String) {
        var dictionary = rules[selector] ?? [:]
        attributes.forEach({ dictionary[$0] = $1 })
        rules[selector] = dictionary
    }

    public func addingAttributes(_ attributes: [String: Any], forSelectors selectors: Set<String>) -> Stylesheet {
        var stylesheet = self
        stylesheet.addAttributes(attributes, forSelectors: selectors)
        return stylesheet
    }

    public func addingAttributes(_ attributes: [String: Any], forSelector selector: String) -> Stylesheet {
        return addingAttributes(attributes, forSelectors: [selector])
    }

    public mutating func setAttributes(_ attributes: [String: Any], forSelectors selectors: Set<String>) {
        selectors.forEach({
            setAttributes(attributes, forSelector: $0)
        })
    }

    public mutating func setAttributes(_ attributes: [String: Any], forSelector selector: String) {
        rules[selector] = attributes
    }

    public func settingAttributes(_ attributes: [String: Any], forSelectors selectors: Set<String>) -> Stylesheet {
        var stylesheet = self
        stylesheet.setAttributes(attributes, forSelectors: selectors)
        return stylesheet
    }

    public func settingAttributes(_ attributes: [String: Any], forSelector selector: String) -> Stylesheet {
        return settingAttributes(attributes, forSelectors: [selector])
    }
}
