//
//  TaskStatus.swift
//  IKIGAI
//
//  Created by Nursultan Bukenbayev on 20.01.2025.
//

import Foundation

enum TaskStatus: String, Codable, CaseIterable {
    case todo = "To Do"
    case inProgress = "In Progress"
    case review = "Review"
    case done = "Done"
}
