//
//  URLComponentsBuilder.swift
//  URLComponentsBuilder
//
//  Created by Alexander Solis on 5/10/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import Foundation

/**
 Builder pattern for URLComponents. Main features is conversion of Dictionaries
 into URLQueryItems using the 'addQuery(items:)' function.
 
 - Arrays will be converted to: < key >[]=<array value 1>&< key >[]=<array value 2>
 Example: phone[]=123456654&phone[]=654234123
 
 - Dictionaries will be converted to: < key >[nestedKey]=< value >&< key >[nestedKey]=< value >
 Example: phone[office]=123456654&phone[mobile]=1654234123

 */
class URLComponentsBuilder {
    
    private var urlComponents = URLComponents()

    /**
     Completes de builder pattern by returning the URLComponents object.
     - returns: URLComponent: constructed with the specified builder attributes.
     */
    func build() -> URLComponents {
        return urlComponents
    }

    /**
     Sets the scheme attribute of URLComponents.
     - parameter scheme: that will be set for URLComponents (e.g. https).
     - returns: URLComponentsBuilder
     */
    func setScheme(_ scheme: String) -> URLComponentsBuilder {
        urlComponents.scheme = scheme
        return self
    }

    /**
     Sets the host attribute of URLComponents.
     - parameter host: that will be set for URLComponents.
     - returns: URLComponentsBuilder
     */
    func setHost(_ host: String) -> URLComponentsBuilder {
        urlComponents.host = host
        return self
    }

    /**
     Sets the path attribute of URLComponents.
     - parameter path: that will be set for URLComponents.
     - returns: URLComponentsBuilder
     */
    func setPath(_ path: String) -> URLComponentsBuilder {
        urlComponents.path = path
        return self
    }

    /**
     Adds parameters to the query. If there are parameters that were set previously, the new
     parameters will be appended to the existing ones.
     
     The 'Any' component of the dictionary can be of types: String, Bool, Int, Double, [String]
     and [String: String]
     
     - Bool 'true' will be converted to '1' and 'false' to '0'
     
     - Array will be converted to: < key >[]=<array value 1>&< key >[]=<array value 2>
     Example: phone[]=123456654&phone[]=654234123
    
     - Dictionary will be converted to: < key >[nestedKey]=< value >&< key >[nestedKey]=< value >
     Example: phone[office]=123456654&phone[mobile]=1654234123
     
     IMPORTANT: If an unsupported type is passed, it will assert in this function call.
     
     - parameter items: a dictionary of [String: Any] to be set as the query.
     - returns: URLComponentsBuilder
     */
    func addQuery(items: [String: Any]) -> URLComponentsBuilder {
        urlComponents.addQuery(items)
        return self
    }

}

extension URLComponents {
    fileprivate mutating func addQuery(_ items: [String: Any]) {
        var queryItems = [URLQueryItem]()
        
        // Sort the collection to ensure consistent ordering in query string.
        for (key, value) in items.sorted(by: { $0.key < $1.key }) {
            queryItems += queryItemsFrom(key: key, value: value)
        }
        
        if self.queryItems == nil {
            self.queryItems = queryItems
        } else {
            self.queryItems?.append(contentsOf: queryItems)
        }
    }
    
    private func queryItemsFrom(key: String, value: Any) -> [URLQueryItem] {
        var queryItems = [URLQueryItem]()
        
        if let element = value as? String {
            queryItems.append(URLQueryItem(name: key, value: element))
        }
        
        if let element = value as? Bool {
            queryItems.append(URLQueryItem(name: key, value: element ? "1" : "0"))
        }
        
        if let element = value as? Int {
            queryItems.append(URLQueryItem(name: key, value: String(element)))
        }
        
        if let element = value as? Double {
            queryItems.append(URLQueryItem(name: key, value: String(element)))
        }
        
        if let element = value as? [String] {
            for nestedValue in element {
                queryItems += queryItemsFrom(key: "\(key)[]", value: nestedValue)
            }
        }
        
        if let element = value as? [String: String] {
            // Sort the collection to ensure consistent ordering in query string.
            for (nestedKey, nestedValue) in element.sorted(by: { $0.key < $1.key }) {
                queryItems += queryItemsFrom(key: "\(key)[\(nestedKey)]", value: nestedValue)
            }
        }
        
        assert(!queryItems.isEmpty, "An unsupported type was found in 'value'")
        
        // TODO: Set and Data are pending and should get the same treatment.
        
        return queryItems
    }
}
