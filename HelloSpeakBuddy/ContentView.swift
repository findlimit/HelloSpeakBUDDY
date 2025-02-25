//
//  ContentView.swift
//  HelloSpeakBuddy
//
//  Created by Peter Hsu on 2025/2/24.
//

import SwiftUI

struct ContentView: View {
    
    // Adjust layout metrics based on the size classes
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var HORI_MARGIN: CGFloat {
        horizontalSizeClass == .compact ? 20 : 60
    }
    var DISMISS_BTN_WIDTH: CGFloat {
        horizontalSizeClass == .compact ? 38 : 48
    }

    // State for graph animation
    @State private var graphHeight: CGFloat = 0
    @State private var showGraph = false
    
    var body: some View {
        
        ZStack {
            VStack {
                // Header Text
                Text("Hello SpeakBUDDY")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 56)
                    .padding(.horizontal, 40)
                    .multilineTextAlignment(.center)
                
                // Graph
                GraphView(showGraph: $showGraph)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.top, 85)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                
                // Desc Texts
                VStack {
                    Text("スピークバディで")
                    Text("レベルアップ")
                }
                .padding(.top, 30)
                .padding(.bottom, 25)
                
                // Button to register plan
                Button(action: {
                    // Handle registration action
                }) {
                    Text("プランに登録する")
                        .frame(maxWidth: .infinity, maxHeight: 50)
                        .foregroundColor(.white)
                        .background(.blue)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            .onAppear {
                // Animate the graph when the view appears
                withAnimation(.easeInOut(duration: 2.0)) {
                    self.showGraph = true
                }
            }

            // Dismiss btn
            Button {
                // Handle action
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundStyle(.black, .white)
                    .font(.system(size: DISMISS_BTN_WIDTH))
            }
            .shadow(radius: 10, y: 2)
            .position(x: UIScreen.main.bounds.width - DISMISS_BTN_WIDTH / 2 - HORI_MARGIN * 2, y: 8 + DISMISS_BTN_WIDTH / 2) // Positions the button at the top-right corner
        }
        .padding(.horizontal, HORI_MARGIN)
    }
}

struct GraphView: View {
    @Binding var showGraph: Bool
    
    // Heights for the bars (in percentage of the max height)
    let heights: [CGFloat] = [0.22, 0.33, 0.73, 1.0]
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<heights.count, id: \.self) { index in
                VStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 48, height: showGraph ? (300 * heights[index]) : 0)
                        .animation(.easeInOut(duration: 2.0), value: showGraph)
                    
                    Text(self.getGraphLabel(index: index))
                        .font(.system(size: 12))
                        .padding(.top, 5)
                }
                
                if index < heights.count - 1 {
                    Spacer()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .overlay() {
            // Character Image
            Image("protty") // Assuming image is named buddyCharacter
                .resizable()
                .scaledToFit()
                .frame(height: 160)
                .position(x: 56, y: 28)
            
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
        ContentView()
            .previewDevice("iPhone 14")
    }
}
