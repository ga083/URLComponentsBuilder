//
//  URLComponentsBuilderTests.swift
//  URLComponentsBuilderTests
//
//  Created by Alexander Solis on 5/10/19.
//  Copyright © 2019 MellonTec. All rights reserved.
//

import XCTest
@testable import URLComponentsBuilder

class URLComponentsBuilderTests: XCTestCase {

    var sut: URLComponentsBuilder!
    
    override func setUp() {
        sut = URLComponentsBuilder()
        .setScheme("http")
        .setHost("urlbuilder.com")
        .setPath("/api/")
    }

    override func tearDown() {
    }

    func test_Scheme_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.scheme, "http")
    }

    func test_Host_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.host, "urlbuilder.com")
    }
    
    func test_Path_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.path, "/api/")
    }

    func test_Query_WithStringParameters() {
        let query: [String: Any] = [
            "name": "Tony",
            "lastname": "Stark"]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "lastname=Stark&name=Tony")
    }
    
    func test_Query_WithBoolParameters() {
        let query: [String: Any] = [
            "hasMotorcycle": true,
            "hasCar": false]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "hasCar=0&hasMotorcycle=1")

    }
    
    func test_Query_WithNumberParameters() {
        let query: [String: Any] = [
            "motorcyclePrice": 22000,
            "weightKg": 238.6]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "motorcyclePrice=22000&weightKg=238.6")
    }
    
    func test_Query_WithArrayParameters() {
        let query: [String: Any] = [
            "phoneNumbers": ["12345678", "87654321", "12348765"]]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery,
                       "phoneNumbers%5B%5D=12345678&phoneNumbers%5B%5D=87654321&phoneNumbers%5B%5D=12348765")
    }
    
    func test_Query_WithDictionaryParameters() {
        let query: [String: Any] = [
            "users": ["name": "John",
                      "lastname": "Doe"]]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "users%5Blastname%5D=Doe&users%5Bname%5D=John")
    }

    func test_Query_PercentEncoding() {
        let query: [String: Any] = [
            "username": "dasdöm",
            "password": "%&34"]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "password=%25%2634&username=dasd%C3%B6m")
    }
   
    func test_Query_AppendMoreParameters() {
        let query: [String: Any] = [
            "username": "dasdöm",
            "password": "%&34"]

        _ = sut.addQuery(items: ["power": true])
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery, "power=1&password=%25%2634&username=dasd%C3%B6m")
    }
}
