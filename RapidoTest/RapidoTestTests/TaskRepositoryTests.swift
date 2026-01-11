//
//  RapidoTestTests.swift
//  RapidoTestTests
//
//  Created by Iron Man on 10/01/26.
//

import XCTest
@testable import RapidoTest
internal import CoreData

final class TaskRepositoryTests: XCTestCase {
    private var sut: TaskRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = TaskRepository(persistenceStorage: PersistenceContainer.shared, dataModifier: TaskModifier())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testAddTaskAndDelete() {
        let now = Date()
        let mockTask = Task(id: UUID(), title: "mockTask", decription: "mockDescription", isCompleted: false, dueDate: now)
        
        sut.addTask(task: mockTask)
        
        var result = getTask(with: mockTask.id)
        
        XCTAssertNotNil(result)
        XCTAssertEqual(mockTask.title, result?.title)
        XCTAssertEqual(mockTask.decription, result?.taskDescription)
        XCTAssertEqual(mockTask.isCompleted, result?.isCompleted)
        XCTAssertEqual(mockTask.dueDate, result?.dueDate)
        
        sut.delete(id: mockTask.id)
        
        result = getTask(with: mockTask.id)
        
        XCTAssertNil(result)
        XCTAssertNotEqual(mockTask.title, result?.title)
        XCTAssertNotEqual(mockTask.decription, result?.taskDescription)
        XCTAssertNotEqual(mockTask.isCompleted, result?.isCompleted)
        XCTAssertNotEqual(mockTask.dueDate, result?.dueDate)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    private func getTask(with id: UUID) -> CDTask? {
        let fetchRequest = CDTask.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id==%@", id as CVarArg)
        do {
            let result = try PersistenceContainer.shared.viewContext.fetch(fetchRequest)
            return result.first
        } catch {
            debugPrint(error)
        }
        return nil
    }
}
