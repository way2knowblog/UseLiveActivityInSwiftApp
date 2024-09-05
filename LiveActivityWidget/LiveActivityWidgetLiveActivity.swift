//
//  LiveActivityWidgetLiveActivity.swift
//  LiveActivityWidget
//
//  Created by Balaji Anandan on 13/04/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LiveActivityWidgetLiveActivity: Widget {
    // MARK: - BODY
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: OrderAttributes.self) { context in
            LiveActivityView(state: context.state)
        } dynamicIsland: { context in
            DynamicIsland {
                
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "map.circle")
                        .foregroundColor(.white)
                        .padding(.top, 5)
                }
                
                DynamicIslandExpandedRegion(.trailing) {
                    Image(systemName: "figure.walk.diamond.fill")
                        .foregroundColor(.white)
                        .padding(.top, 5)
                }
                
                DynamicIslandExpandedRegion(.bottom) {
                    LiveActivityView(state: context.state, isDynamicIslandView: true)
                }
            } compactLeading: {
                Image(systemName: "figure.walk.diamond.fill")
                    .scaledToFit()
                    .foregroundColor(.white)
            } compactTrailing: {
                Image(systemName: "car.rear.and.tire.marks")
                    .scaledToFit()
                    .foregroundColor(.white)
            } minimal: {
                Image(systemName: "car.rear.and.tire.marks")
                    .scaledToFit()
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - PREVIEW
struct Widget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .rideBooked), viewKind: .content)
                .previewDisplayName("Lock Screen")
            
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .aboutToPickup), viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Dynamic Island View")
            
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .tripOnTheWay), viewKind: .dynamicIsland(.compact))
                .previewDisplayName("Compact Leading & Trailing")
            
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .tripEnded), viewKind: .dynamicIsland(.minimal))
                .previewDisplayName("Minimal")
        }
    }
}
