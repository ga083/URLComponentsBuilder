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
            .setHost("superherobuilder.com")
            .setPath("/buildSuit/")
    }
    
    override func tearDown() {
    }
    
    func test_Scheme_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.scheme, "http")
    }
    
    func test_Host_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.host, "superherobuilder.com")
    }
    
    func test_Path_HasExpectedValueWhenSet() {
        let urlComponents = sut.build()
        XCTAssertEqual(urlComponents.path, "/buildSuit/")
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
                       "phoneNumbers%5B0%5D=12345678&phoneNumbers%5B1%5D=87654321&phoneNumbers%5B2%5D=12348765")
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
    
    func test_Query_WithDictionaryOfArrayParameters() {
        let query: [String: Any] = ["belongings": ["motorcycles": ["BMW 1200GS",
                                                                   "Triumph Bonneville"]]]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery,
                       "belongings%5Bmotorcycles%5D%5B0%5D=BMW%201200GS&belongings%5Bmotorcycles%5D%5B1%5D=Triumph%20Bonneville")
    }
    
    func test_Query_WithArrayOfDictionaryParameters() {
        let query: [String: [[String: String]]] = ["homes":
            [["name": "Point Dume", "address": "10880 Malibu Point"],
             ["name": "Stark Tower", "address": "200 Park Avenue"]]]
        
        let urlComponents = sut
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.percentEncodedQuery,
                       "homes%5B0%5D%5Baddress%5D=10880%20Malibu%20Point&homes%5B0%5D%5Bname%5D=Point%20Dume&homes%5B1%5D%5Baddress%5D=200%20Park%20Avenue&homes%5B1%5D%5Bname%5D=Stark%20Tower")
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
    
    func test_README_UsageExample() {
        let query: [String: Any] = [
            "name": "Tony",
            "username": "Stark",
            "password": "%&34",
            "isSuperhero": true,
            "weightKg": 75.8,
            "phones": ["mobile": "123456789",
                       "office": "123987456"],
            "homes": [["name": "Point Dume", "address": "10880 Malibu Point"],
            ["name": "Stark Tower", "address": "200 Park Avenue"]],
            "belongings": ["cars": ["1932 Ford Flathead Roadster",
                                    "1967 Shelby Cobra",
                                    "Saleen S7"], "motorcycles": ["zero eng type6"]]]
        
        let urlComponents = URLComponentsBuilder()
            .setScheme("http")
            .setHost("superherobuilder.com")
            .setPath("/buildSuit/")
            .addQuery(items: query)
            .build()
        
        XCTAssertEqual(urlComponents.description, "http://superherobuilder.com/buildSuit/?belongings%5Bcars%5D%5B0%5D=1932%20Ford%20Flathead%20Roadster&belongings%5Bcars%5D%5B1%5D=1967%20Shelby%20Cobra&belongings%5Bcars%5D%5B2%5D=Saleen%20S7&belongings%5Bmotorcycles%5D%5B0%5D=zero%20eng%20type6&homes%5B0%5D%5Baddress%5D=10880%20Malibu%20Point&homes%5B0%5D%5Bname%5D=Point%20Dume&homes%5B1%5D%5Baddress%5D=200%20Park%20Avenue&homes%5B1%5D%5Bname%5D=Stark%20Tower&isSuperhero=1&name=Tony&password=%25%2634&phones%5Bmobile%5D=123456789&phones%5Boffice%5D=123987456&username=Stark&weightKg=75.8")
    }
}

