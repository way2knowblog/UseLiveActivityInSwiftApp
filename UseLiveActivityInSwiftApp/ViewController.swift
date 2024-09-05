//
//  ViewController.swift
//  UseLiveActivityInSwiftApp
//
//  Created by Balaji Anandan on 09/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Do any additional setup after loading the view.
    }
    
    @IBAction func createLiveActivityAction(_ sender: UIButton) {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000) /// DELAYING FOR 2 SECONDS FOR DEMO PURPOSE.
            LiveActivityManager.shared.createLiveActivityRequest()
        }
    }
    
    @IBAction func updateLiveActivityAction(_ sender: UIButton) {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000) /// DELAYING FOR 2 SECONDS FOR DEMO PURPOSE.
            await LiveActivityManager.shared.updateLiveActivity(to: LiveActivityManager.shared.isLiveActivityUpdateOnce ? .tripOnTheWay : .aboutToPickup)
        }
    }
    
    @IBAction func endLiveActivityAction(_ sender: UIButton) {
        Task {
            await LiveActivityManager.shared.endLiveActivity()
        }
    }
    
    @IBAction func createAndAutoUpdateAction(_ sender: UIButton) {
        Task {
            try await Task.sleep(nanoseconds: 2_000_000_000) /// DELAYING FOR 2 SECONDS FOR DEMO PURPOSE.
            LiveActivityManager.shared.stimulateAutoLiveActivityRequest()
        }
    }
}
