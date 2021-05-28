//
//  TaskViewModelTests.swift
//  TaskViewModelTests
//
//  Created by Felix Houghton-Larsen on 28.05.21.
//

import XCTest
@testable import LocalTaskList

class TaskViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testListStartsOutEmpty() throws {
        let viewModel = TaskViewModel()

        XCTAssertEqual(viewModel.tasks.count, 0)
    }

    func testAddingARandomNumberIncreasesTasksCount() throws {
        let viewModel = TaskViewModel()

        viewModel.addRandomInt()
        XCTAssertEqual(viewModel.tasks.count, 1)
    }

    func testAddingMultipleRandomNumberIncreasesTasksCount() throws {
        let viewModel = TaskViewModel()
        let expectedCount = 5
        for _ in 1...expectedCount {
            viewModel.addRandomInt()
        }
        XCTAssertEqual(viewModel.tasks.count, expectedCount)
    }


    func testFilterIsOff() throws {
        let viewModel = TaskViewModel()

        viewModel.isFilterEnabled = false

        XCTAssertFalse(viewModel.isFilterEnabled)
        XCTAssertEqual(viewModel.filteredTasks, viewModel.tasks)
    }

    func testFilterOnIsCorrectlyApplied() throws {
        let viewModel = TaskViewModel()
        viewModel.tasks = [4,6,3,6,1,2,5]
        let expectedFilteredList = [1,2]
        viewModel.isFilterEnabled = true
        let exp = expectation(description: "expected values")

        let cancelable = viewModel.$filteredTasks
            .sink { value in
                if value == expectedFilteredList {
                    exp.fulfill()
                }
            }

        wait(for: [exp], timeout: 1)
        XCTAssertNotNil(cancelable)
        XCTAssertTrue(viewModel.isFilterEnabled)
        XCTAssertEqual(viewModel.filteredTasks, expectedFilteredList)
        XCTAssertGreaterThan(viewModel.tasks.count, viewModel.filteredTasks.count)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
