//
//  HelloSpeakBuddyTests.swift
//  HelloSpeakBuddyTests
//
//  Created by Peter Hsu on 2025/2/24.
//

import Testing
@testable import HelloSpeakBuddy

struct SubsriptionViewModelTests {
    
    @Test("Initialization")
    func test_initialization() async throws {
        let viewModel = TestableSubscriptionViewModel()
        #expect(!viewModel.showGraph)
    }

    @Test("Register Plan")
    func test_register_plan() async throws {
        let viewModel = TestableSubscriptionViewModel()
        viewModel.registerPlan()
        #expect(viewModel.registerPlanCalled)
        // Other assertions about real registeration logic
        // or did call the function of the other service, such as SubscriptionManager
    }
    
    @Test("Dismiss View")
    func test_dismiss_view() async throws {
        let viewModel = TestableSubscriptionViewModel()
        viewModel.dismiss()
        #expect(viewModel.dismissCalled)
        // Other assertions about dismissing view logic
    }
}
