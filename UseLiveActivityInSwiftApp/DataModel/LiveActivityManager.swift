//
//  LiveActivityManager.swift
//  UseLiveActivityInSwiftApp
//
//  Created by Balaji Anandan on 13/04/24.
//

import Foundation
import ActivityKit

final class LiveActivityManager {
    static let shared = LiveActivityManager()
    private var currentLiveActivitiesArray = [Activity<OrderAttributes>]() /// MAKING IT AS ARRAY TO HANDLE MULTIPLE LIVE ACTIVIES TO THE APP.
    var isLiveActivityUpdateOnce = false /// HAVING THIS FLAG ONLY TO SHOW THE DEMO BEHAVIOUR OF THE LIVE ACTIVITY UPDATIONS.
    
    func createLiveActivityRequest() {
        let orderAttributes = OrderAttributes(tripNumber: 0123) /// `0123` IS DUMMY TRIP NUMBER FOR TRIP IDENTIFICATION.
        let initialTripState = OrderAttributes.ContentState(tripStatus: .rideBooked, currentTripNumber: 1)
        let activityContent = ActivityContent(state: initialTripState.self, staleDate: nil)
        
        do {
            let activity = try ActivityKit.Activity.request(attributes: orderAttributes,
                                                            content: activityContent,
                                                            pushType: nil)
            currentLiveActivitiesArray.append(activity)
        } catch {
            print("Error in Creating a Live Activity: ", error.localizedDescription)
        }
    }
    
    // MARK: - UPDATE LIVE ACTIVITY.
    func updateLiveActivity(to status: TripStatus) async {
        guard let activity = currentLiveActivitiesArray.first(where: { $0.attributes.tripNumber == 0123 }) else { return }
        let updatedState = OrderAttributes.ContentState(tripStatus: status)
        let updateContent = ActivityContent(state: updatedState.self, staleDate: nil)
        let alertConfig = AlertConfiguration(title: "Updating the Live Activity.", body: "", sound: .default) /// ALERT CONFIGURATION HERE!.
        await activity.update(updateContent, alertConfiguration: alertConfig)
        isLiveActivityUpdateOnce = true
    }
    
    // MARK: - END LIVE ACTIVITY.
    func endLiveActivity() async {
        guard let activity = currentLiveActivitiesArray.first(where: { $0.attributes.tripNumber == 0123 }) else { return }
        let updatedState = OrderAttributes.ContentState(tripStatus: .tripEnded)
        let updateContent = ActivityContent(state: updatedState.self, staleDate: nil)
        await activity.end(updateContent,dismissalPolicy: .after(Date() + 5))
        isLiveActivityUpdateOnce = false
        currentLiveActivitiesArray.removeAll()
    }
    
    // MARK: - STIMULATE AUTO LIVE ACTIVITY
    /// Method to Automatically `CREATE, UPDATE & END` a Live Activity for a small flow DEMO.
    func stimulateAutoLiveActivityRequest() {
        createLiveActivityRequest()
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000) /// DELAYING THE ACTIVITY FOR 2 SECONDS FOR DEMO PURPOSE.
            await updateLiveActivity(to: .aboutToPickup)
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await updateLiveActivity(to: .tripOnTheWay)
            try await Task.sleep(nanoseconds: 2_000_000_000)
            await endLiveActivity()
        }
    }
}
