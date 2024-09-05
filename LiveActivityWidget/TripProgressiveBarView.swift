//
//  TripProgressiveBarView.swift
//  LiveActivityWidgetExtension
//
//  Created by Balaji Anandan on 17/04/24.
//

import SwiftUI

struct TripProgressiveBarView: View {
    
    // MARK: - PROPERTIES
    @State private var containerWidth: CGFloat = 0
    let currentStatusValue: Int
    let totalStatusCount: Int
    
    var maxWidth: Double {
        return min(containerWidth / CGFloat(totalStatusCount) * CGFloat(currentStatusValue), containerWidth)
    }
    
    // MARK: - BODY
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.clear)
                        .onAppear {
                            containerWidth = geo.size.width
                        }
                }
                
                RoundedRectangle(cornerRadius: 60)
                    .stroke(Color.purple, lineWidth: 1)
                
                ZStack(alignment: .trailing) {
                    RoundedRectangle(cornerRadius: 60)
                        .fill(Color.purple)
                    
                    Image(systemName: "car.side")
                        .font(.system(size: 25))
                        .scaleEffect(x: -1, y: 1) /// 😄 Inverting horizontally the car image from Left-to-Right.
                        .foregroundColor(.white)
                }
                .frame(minWidth: maxWidth)
                .fixedSize()
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.zero)
        }
    }
}

// MARK: - PREVIEW
struct TripProgressiveBarView_Previews: PreviewProvider {
    static var previews: some View {
        OrderAttributes.preview
            .previewContext(.init(tripStatus: .aboutToPickup), viewKind: .content)
    }
}
