//
//  ImgrTests.swift
//  ImgrTests
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import XCTest
@testable import Imgr

final class ImgrTests: XCTestCase {
    
    var viewModelUnderTest: ContentViewModel!
    var mockPhotosAccess: PhotosPermissionMock!
    
    override func setUpWithError() throws {
        self.mockPhotosAccess = PhotosPermissionMock()
        self.viewModelUnderTest = ContentViewModel(photoAuthorizer: self.mockPhotosAccess!)
    }

    override func tearDownWithError() throws {
        
    }

    func testRejectedAccess() throws {
        
        //Given
        self.mockPhotosAccess.mockStatus = .denied
        let expectation = XCTestExpectation(description: "Wait for main thread")

        // When
        self.viewModelUnderTest.requestPhotosPermissions()
        self.viewModelUnderTest.setStatusOnMainThread(viewState: self.mockPhotosAccess.returnPhotosAuth())
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModelUnderTest.errorCode, "0002")
            XCTAssertEqual(self.viewModelUnderTest.errorDescription, "Photos permission currently currently denied, please allow access in settings.")
            XCTAssertTrue(self.viewModelUnderTest.showingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testNotDetermindAccess() throws {
        
        //Given
        self.mockPhotosAccess.mockStatus = .notDetermined
        let expectation = XCTestExpectation(description: "Wait for main thread")

        // When
        self.viewModelUnderTest.requestPhotosPermissions()
        self.viewModelUnderTest.setStatusOnMainThread(viewState: self.mockPhotosAccess.returnPhotosAuth())
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModelUnderTest.errorCode, "0001")
            XCTAssertEqual(self.viewModelUnderTest.errorDescription, "Photos permission currently unknown, please allow access.")
            XCTAssertTrue(self.viewModelUnderTest.showingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testAuthorizedAccess() throws {
        
        //Given
        self.mockPhotosAccess.mockStatus = .authorized
        let expectation = XCTestExpectation(description: "Wait for main thread")

        // When
        self.viewModelUnderTest.requestPhotosPermissions()
        self.viewModelUnderTest.setStatusOnMainThread(viewState: self.mockPhotosAccess.returnPhotosAuth(),
                                                      errorState: false)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModelUnderTest.errorCode, "")
            XCTAssertEqual(self.viewModelUnderTest.errorDescription, "")
            XCTAssertFalse(self.viewModelUnderTest.showingError)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
