//
//  StringProtocol+Utils.swift
//  APExtensions
//
//  Created by Anton Plebanovich on 1/4/20.
//  Copyright © 2020 Anton Plebanovich. All rights reserved.
//

import Foundation

// ******************************* MARK: - Representation

public extension StringProtocol {
    
    /// Returns string as URL. Properly escapes URL components if needed.
    var asURL: URL? {
        // Check for existing percent escapes first to prevent double-escaping of % character
        if range(of: "%[0-9A-Fa-f]{2}", options: .regularExpression, range: nil, locale: nil) != nil {
            // Already encoded
            return URL(string: asString)
        }
        
        // Gettin host component
        var reducedString = asString
        var components = reducedString.components(separatedBy: "://")
        let hostComponent: String
        if components.count == 2 {
            hostComponent = components[0]
            reducedString = components[1]
        } else {
            hostComponent = ""
        }
        
        // Getting fragment component
        components = reducedString.components(separatedBy: "#")
        let fragmentComponent: String
        if components.count == 2 {
            reducedString = components[0]
            fragmentComponent = components[1]
        } else {
            reducedString = components[0]
            fragmentComponent = ""
        }
        
        // Getting query component
        components = reducedString.components(separatedBy: "?")
        let queryComponent: String
        if components.count == 2 {
            reducedString = components[0]
            queryComponent = components[1]
        } else {
            reducedString = components[0]
            queryComponent = ""
        }
        
        // What have left is a path
        let pathComponent: String = reducedString
        
        guard let escapedHostComponent = hostComponent.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return nil }
        guard let escapedPathComponent = pathComponent.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else { return nil }
        guard let escapedQueryComponent = queryComponent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        guard let escapedFragmentComponent = fragmentComponent.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return nil }
        
        var urlString = ""
        
        if !escapedHostComponent.isEmpty {
            urlString = "\(escapedHostComponent)://"
        }
        
        if !escapedPathComponent.isEmpty {
            urlString = "\(urlString)\(escapedPathComponent)"
        }
        
        if !escapedQueryComponent.isEmpty {
            urlString = "\(urlString)?\(escapedQueryComponent)"
        }
        
        if !escapedFragmentComponent.isEmpty {
            urlString = "\(urlString)#\(escapedFragmentComponent)"
        }
        
        return URL(string: urlString)
    }
    
    /// Returns `self` as `Int`
    var asInt: Int? {
        return Int(self)
    }
    
    /// Returns `self` as `Double`
    var asDouble: Double? {
        return Double(self)
    }
    
    /// Returns `self` as `String`
    var asString: String {
        return String(self)
    }
    
    /// Returns string as NSAttributedString
    var asAttributedString: NSAttributedString {
        return NSAttributedString(string: asString)
    }
    
    /// Returns string as NSMutableAttributedString
    var asMutableAttributedString: NSMutableAttributedString {
        return NSMutableAttributedString(string: asString)
    }
}

// ******************************* MARK: - Base64

public extension StringProtocol {
    /// Returns base64 encoded string
    var encodedBase64: String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    /// Returns string decoded from base64 string
    var decodedBase64: String? {
        // String MUST be dividable by 4. https://stackoverflow.com/questions/36364324/swift-base64-decoding-returns-nil/36366421#36366421
        let remainder = count % 4
        let encodedString: String
        if remainder > 0 {
            encodedString = padding(toLength: count + 4 - remainder, withPad: "=", startingAt: 0)
        } else {
            encodedString = self.asString
        }
        
        guard let data = Data(base64Encoded: encodedString) else { return nil }
        
        return String(data: data, encoding: .utf8)
    }
}

// ******************************* MARK: - Trimming

public extension StringProtocol {
    /// Strips whitespace and new line characters
    var trimmed: String {
        let trimmedString = trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        return trimmedString
    }
}

// ******************************* MARK: - Splitting

public extension StringProtocol {
    /// Splits string by capital letters without stripping them
    var splittedByCapitals: [String] {
        return splitBefore(separator: { $0.isUpperCase }).map({ String($0) })
    }
    
    /// Split string into slices of specified length
    func splitByLength(_ length: Int) -> [String] {
        var result = [String]()
        var collectedCharacters = [Character]()
        collectedCharacters.reserveCapacity(length)
        var count = 0
        
        for character in self {
            collectedCharacters.append(character)
            count += 1
            if (count == length) {
                // Reached the desired length
                count = 0
                result.append(String(collectedCharacters))
                collectedCharacters.removeAll(keepingCapacity: true)
            }
        }
        
        // Append the remainder
        if !collectedCharacters.isEmpty {
            result.append(String(collectedCharacters))
        }
        
        return result
    }
}

// ******************************* MARK: - Bounding Rect

public extension StringProtocol {
    /// Width of a string written in one line.
    func oneLineWidth(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = asString.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return boundingBox.width
    }
    
    /// Height of a string for specified font and width.
    func height(font: UIFont, width: CGFloat) -> CGFloat {
        return height(attributes: [.font: font], width: width)
    }
    
    /// Height of a string for specified attributes and width.
    func height(attributes: [NSAttributedString.Key: Any], width: CGFloat) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let height = asString.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).height + c.pixelSize
        
        return height
    }
}

// ******************************* MARK: - Capitalization

public extension StringProtocol {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}