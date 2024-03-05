//
//  Task.swift
//  Vero_ios_task
//
//  Created by ertugrul on 4.03.2024.
//

import Foundation

struct Task: Codable {
    let task: String
    let title: String
    let description: String
    let colorCode: String
    
    let sort: String
    let wageType: String
    let BusinessUnitKey: String?
    let businessUnit: String
    let parentTaskID: String?
    let preplanningBoardQuickSelect: String?
    let workingTime: String?
    let isAvailableInTimeTrackingKioskMode: Bool
    
}
