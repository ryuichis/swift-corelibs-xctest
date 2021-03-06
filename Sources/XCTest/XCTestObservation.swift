// This source file is part of the Swift.org open source project
//
// Copyright (c) 2016 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See http://swift.org/LICENSE.txt for license information
// See http://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//
//  XCTestObservation.swift
//  Hooks for being notified about progress during a test run.
//

#if os(Linux) || os(FreeBSD)
    import Foundation
#else
    import SwiftFoundation
#endif

/// `XCTestObservation` provides hooks for being notified about progress during a
/// test run.
/// - seealso: `XCTestObservationCenter`
public protocol XCTestObservation: class {

    /// Sent immediately before tests begin as a hook for any pre-testing setup.
    /// - Parameter testBundle: The bundle containing the tests that were
    ///   executed.
    func testBundleWillStart(testBundle: NSBundle)

    /// Called just before a test begins executing.
    /// - Parameter testCase: The test case that is about to start. Its `name`
    ///   property can be used to identify it.
    func testCaseWillStart(testCase: XCTestCase)

    /// Called when a test failure is reported.
    /// - Parameter testCase: The test case that failed. Its `name` property 
    ///   can be used to identify it.
    /// - Parameter description: Details about the cause of the test failure.
    /// - Parameter filePath: The path to the source file where the failure
    ///   was reported, if available.
    /// - Parameter lineNumber: The line number in the source file where the
    ///   failure was reported.
    func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt)

    /// Called just after a test finishes executing.
    /// - Parameter testCase: The test case that finished. Its `name` property 
    ///   can be used to identify it.
    func testCaseDidFinish(testCase: XCTestCase)

    /// Sent immediately after all tests have finished as a hook for any
    /// post-testing activity. The test process will generally exit after this
    /// method returns, so if there is long running and/or asynchronous work to
    /// be done after testing, be sure to implement this method in a way that
    /// it blocks until all such activity is complete.
    /// - Parameter testBundle: The bundle containing the tests that were
    ///   executed.
    func testBundleDidFinish(testBundle: NSBundle)
}

// All `XCTestObservation` methods are optional, so empty default implementations are provided
public extension XCTestObservation {
    func testCaseWillStart(testCase: XCTestCase) {}
    func testCase(testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: UInt) {}
    func testCaseDidFinish(testCase: XCTestCase) {}
}
