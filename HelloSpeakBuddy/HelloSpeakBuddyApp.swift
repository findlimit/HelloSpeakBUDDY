//
//  HelloSpeakBuddyApp.swift
//  HelloSpeakBuddy
//
//  Created by Peter Hsu on 2025/2/24.
//

import SwiftUI

@main
struct HelloSpeakBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            SubscriptionView(viewModel: SubscriptionViewModel())
        }
    }
}
