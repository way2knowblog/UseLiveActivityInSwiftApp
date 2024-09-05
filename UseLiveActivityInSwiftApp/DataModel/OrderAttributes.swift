//
//  OrderAttributes.swift
//  UseLiveActivityInSwiftApp
//
//  Created by Balaji Anandan on 13/04/24.
//

import ActivityKit

struct OrderAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        let tripStatus: TripStatus
        var currentTripNumber: Int
        
        init(tripStatus: TripStatus = .aboutToPickup, currentTripNumber: Int = 0) {
            self.tripStatus = tripStatus
            self.currentTripNumber = currentTripNumber
        }
    }
    let tripNumber: Int
}

enum TripStatus: Float, Codable, Hashable {
    case rideBooked = 1
    case aboutToPickup
    case tripOnTheWay
    case tripEnded
    
    var description: String {
        switch self {
        case .rideBooked:
            return "Your ride has been booked!"
        case .aboutToPickup:
            return "Your Trip is on the way to Pickup you."
        case .tripOnTheWay:
            return "Trip Verified & You're on the way."
        case .tripEnded:
            return "You've successfully completed the trip."
        }
    }
    
    static var allCases: [TripStatus] {
        return [.rideBooked, .aboutToPickup, .tripOnTheWay, .tripEnded]
    }
}

// MARK: - PREVIEW SETUP
extension OrderAttributes {
    static var preview: OrderAttributes {
        return OrderAttributes(tripNumber: 1)
    }
}
