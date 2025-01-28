//
//  KanbanTask.swift
//  IKIGAI
//
//  Created by Nursultan Bukenbayev on 20.01.2025.
//

import Foundation

struct KanbanTask: Identifiable {
    let id = UUID()
    var title: String
    var description: String
}
