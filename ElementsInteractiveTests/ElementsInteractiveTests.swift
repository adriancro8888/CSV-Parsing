//
//  ElementsInteractiveTests.swift
//  ElementsInteractiveTests
//
//  Created by Shabir Jan on 3/10/18.
//  Copyright © 2018 Shabir Jan. All rights reserved.
//

import XCTest
@testable import ElementsInteractive

class ElementsInteractiveTests: XCTestCase {
    func testElementCellCorrectValues() {
        let element = Element(title: "Hello", description: "Description", photoURL: nil)
        let viewmodel = ElementCellViewModel(element: element, imageCache: MockImageCache())
  
        XCTAssertEqual(viewmodel.title, "Hello")
        XCTAssertEqual(viewmodel.desc, "Description")
    
    }
}
