//
//  KanbanColumn.swift
//  IKIGAI
//
//  Created by Nursultan Bukenbayev on 20.01.2025.
//

import Foundation

struct KanbanColumn: Identifiable {
    let id = UUID()
    var name: String
    var tasks: [KanbanTask]
}
