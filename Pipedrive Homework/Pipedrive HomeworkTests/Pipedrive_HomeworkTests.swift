//
//  Pipedrive_HomeworkTests.swift
//  Pipedrive HomeworkTests
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import XCTest
@testable import Pipedrive_Homework

final class Pipedrive_HomeworkViewModelTests: XCTestCase {
    var viewModel: PersonViewModel!
    
    func testFetchingPersons() async {
        // Given
        let mockPersonService = MockPersonService()
        viewModel = PersonViewModel(personService: mockPersonService, itemsFromEndThreshold: 1, limit: 10)
        
        // When
        await viewModel.getPersonList()
        
        // Then
        XCTAssertNotNil(viewModel.personList)
        
        // 10 is the limit in the ViewModel, which tells us how many items it'll fetch
        XCTAssertEqual(viewModel.personList.count, 10)
        XCTAssertEqual(viewModel.personList[0].id, MockPersonService.mockPersonList[0].id)
    }
    
    func testFetchingAdditionalPersons() async {
        // Given
        let mockPersonService = MockPersonService()
        viewModel = PersonViewModel(personService: mockPersonService, itemsFromEndThreshold: 1, limit: 15)
        
        // When
        await viewModel.getPersonList()
        
        /// The index 14 is the threshold index for fetching more people:
        /// - If the limit is 15 and the itemsFromEndThreshold is 1, it'll fetch more data, if more items are available
        await viewModel.requestMore(index: 14)
        
        // Then
        XCTAssertNotNil(viewModel.personList)
        XCTAssertEqual(viewModel.personList.count, MockPersonService.mockPersonList .count)
        XCTAssertEqual(viewModel.personList[0].id, MockPersonService.mockPersonList[0].id)
    }
    
}
