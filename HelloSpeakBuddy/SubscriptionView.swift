//
//  SubscriptionView.swift
//  HelloSpeakBuddy
//
//  Created by Peter Hsu on 2025/2/24.
//

import SwiftUI

struct SubscriptionView: View {
    
    // Adjust layout metrics based on the size classes
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    private var HORI_MARGIN: CGFloat {
        horizontalSizeClass == .compact ? 20 : 60
    }
    private var DISMISS_BTN_WIDTH: CGFloat {
        horizontalSizeClass == .compact ? 38 : 48
    }
    private var ACTION_BTN_MAX_WIDTH_RATIO: Double {
        horizontalSizeClass == .compact ? 1 : 0.5
    }
    
    // Adjust layout metrics to support both TouchID / FaceID devices
    @Environment(\.safeAreaInsets) var safeAreaInsets
    private var ACTION_BTN_BOTTOM_MARGIN: CGFloat {
        safeAreaInsets.bottom > 0 ? 20 : 40
    }
    private var HEADER_TEXT_TOP_MARGIN: CGFloat {
        safeAreaInsets.bottom + ACTION_BTN_BOTTOM_MARGIN
    }
    
    private var SCREEN_SIZE: CGRect {
        UIScreen.main.bounds
    }

    // State for graph animation
    @State private var graphHeight: CGFloat = 0
    @State private var showGraph = false
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center) {
                // Header Text
                Spacer().frame(height: HEADER_TEXT_TOP_MARGIN)
                Text("Hello\nSpeakBUDDY")
                    // I prefer using font symbols instead of fixed point sizes to better support Dynamic Type.
                    // This may cause slight differences from the Figma design, but it ensures scalability and accessibility.
                    // Once our design system is established, we can adopt custom typography symbols defined by us.
                    // Using font symbols from the start helps maintain consistency and makes it easier to update styles across the app.
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                
                // Graph
                Spacer().frame(maxHeight: 32).layoutPriority(-1)
                GraphView(showGraph: $showGraph)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: SCREEN_SIZE.height * 0.5
                    )
                    .layoutPriority(-1)
                
                // Desc Texts
                Spacer().frame(height: 30)
                VStack(spacing: 0) {
                    Text("スピークバディで")
                        .font(.headline)
                        .frame(height: 30)
                    Text("レベルアップ")
                        .font(.title)
                        .fontWeight(.bold)
                        .font(Font.system(size: 30, weight: .medium))
                        .kerning(-0.57)
                        .frame(height: 45)
                        .foregroundStyle(
                            // Don't extract colors only use once
                            LinearGradient(colors: [Color(hex: "#6FD4FF"), Color(hex: "#0075FF")], startPoint: .top, endPoint: .bottom)
                        )
                        .multilineTextAlignment(.center)
                }
                Spacer().frame(height: 25)
                
                // Button to register plan
                Button(action: {
                    // TODO: Handle registration action
                }) {
                    Text("プランに登録する")
                        .fontWeight(.semibold)
                        .frame(maxWidth: SCREEN_SIZE.width * ACTION_BTN_MAX_WIDTH_RATIO)
                        .padding()
                        .foregroundStyle(.white)
                        .background(
                            Capsule()
                                .fill(.skyBlue)
                                .stroke(.white, lineWidth: 1)
                                .shadow(radius: 10, y: 10)
                        )
                }
                .padding(.bottom, ACTION_BTN_BOTTOM_MARGIN)
            }
            .onAppear {
                // Animate the graph when the view appears
                self.showGraph = true
            }
            .foregroundStyle(.darkGrey)

            // Dismiss btn
            Button {
                // TODO: Handle action
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.darkGrey, .white)
                    .font(.system(size: DISMISS_BTN_WIDTH))
            }
            .shadow(radius: 10, y: 2)
            // positions the button at the top-right corner
            .position(
                x: UIScreen.main.bounds.width - DISMISS_BTN_WIDTH / 2 - HORI_MARGIN * 2,
                y: 8 + DISMISS_BTN_WIDTH / 2
            )
        }
        .padding(.horizontal, HORI_MARGIN)
        .background(
            LinearGradient(
                // Don't extract colors only use once
                gradient: Gradient(colors: [Color(hex: "#D5D2FF"), Color.white.opacity(0)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

// This view is intended for use in this specific context, so it's kept here.
// If we need to reuse it in other parts of the app, we should refactor it into a separate file.
struct GraphView: View {
    @Binding var showGraph: Bool
    
    // Heights for the bars (in percentage of the max height)
    // These values represent a conceptual growth trend and are not actual data.
    // Since they don't change frequently, there's no need to extract them as parameters.
    let heights: [CGFloat] = [0.22, 0.33, 0.73, 1.0]
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                Spacer().frame(height: 52)
                HStack(alignment: .bottom, spacing: 26) {
                    ForEach(0..<heights.count, id: \.self) { index in
                        VStack {
                            // Don't extract colors only use once
                            LinearGradient(colors: [Color(hex: "#58C0FF"), Color(hex: "#1F8FFF")], startPoint: .top, endPoint: .bottom)
                                .clipShape(
                                    // Don't extract the values that only use once
                                    .rect(
                                        topLeadingRadius: 2.73,
                                        topTrailingRadius: 2.73
                                    )
                                )
                                .frame(width: 48, height: showGraph ? (300 * heights[index]) : 0)
                                .padding(.top, showGraph ? 0 : (300 * heights[index]))
                                .animation(.easeOut(duration: 0.6).delay(0.74 + Double(index) * 0.12), value: showGraph)
                            
                            Text(self.getGraphLabel(index: index))
                                .font(.footnote)
                                .fontWeight(.bold)
                                .padding(.top, 5)
                        }
                    }
                }
                .frame(width: 270, height: 325)
            }
            .overlay {
                // Character Image
                Image("protty")
                    .frame(height: 160)
                    .position(x: 56, y: 80)
            }
            .frame(maxWidth: .infinity)
            .scaleEffect(geometry.size.height / 377, anchor: .top)
        }
    }
    
    private func getGraphLabel(index: Int) -> String {
        switch index {
        case 0:
            return "現在"
        case 1:
            return "3ヶ月"
        case 2:
            return "1年"
        case 3:
            return "2年"
        default:
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
