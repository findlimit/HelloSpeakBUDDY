//
//  SubscriptionViewModel.swift
//  HelloSpeakBuddy
//
//  Created by Peter Hsu on 2025/2/26.
//

import SwiftUI

class SubscriptionViewModel: ObservableObject {
    // Observable state for managing the graph visibility
    @Published var showGraph: Bool = false
    
    // Handle registration action (this can be replaced with real logic)
    func registerPlan() {
        // For example, navigate to a new view or trigger an API call
        print("Plan registered!")  // Placeholder for registration logic
    }
    
    // Handle dismiss action (could be closing the current view or hiding something)
    func dismiss() {
        // Logic to dismiss the view or perform other actions
        print("Dismissed!") // Placeholder for dismiss logic
    }
}

// Example testable view model to validate logic behavior.
// Uses flags to demonstrate whether methods are called.
class TestableSubscriptionViewModel: SubscriptionViewModel {
    
    var registerPlanCalled = false
    var dismissCalled = false
    
    override func registerPlan() {
        super.registerPlan()
        registerPlanCalled = true
    }
    
    override func dismiss() {
        super.dismiss()
        dismissCalled = true
    }
}
