//
//  LiveActivityView.swift
//  LiveActivityWidgetExtension
//
//  Created by Balaji Anandan on 13/04/24.
//

import SwiftUI
import WidgetKit

struct LiveActivityView: View {
    // MARK: - PROPERTIES
    let state: OrderAttributes.ContentState
    var isDynamicIslandView: Bool = false
    
    // MARK: - BoDY
    var body: some View {
        VStack {
            Text("Pick Mee Up!")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(isDynamicIslandView ? .white : .blue)
                .padding(.top, 5)
            HStack {
                Image(systemName: "car.front.waves.up.fill")
                    .foregroundColor(isDynamicIslandView ? .white : .blue)
                
                TripProgressiveBarView(currentStatusValue: Int(state.tripStatus.rawValue), totalStatusCount: TripStatus.allCases.count)
                
                Image(systemName: "car.rear.and.tire.marks")
                    .foregroundColor(isDynamicIslandView ? .white : .blue)
            }
            .padding(isDynamicIslandView ? .zero : 16)
            
            Text("\(state.tripStatus.description)")
                .font(.system(size: 16, weight: .semibold))
                .padding(.top, 5)
                .foregroundColor(isDynamicIslandView ? .white : .blue)
            Spacer()
        }
    }
}

// MARK: - PREVIEW
struct LiveActivityView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .rideBooked), viewKind: .content)
                .previewDisplayName("Lock Screen")
            
            OrderAttributes.preview
                .previewContext(.init(tripStatus: .aboutToPickup), viewKind: .dynamicIsland(.expanded))
                .previewDisplayName("Dynamic Island View")
        }
    }
}
