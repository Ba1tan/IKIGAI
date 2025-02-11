//
//  KanbanBoardViewModel.swift
//  IKIGAI
//
//  Created by Nursultan Bukenbayev on 27.01.2025.
//

import Foundation

class KanbanBoardViewModel: ObservableObject {
    @Published var columns: [KanbanColumn] = [
        KanbanColumn(name: "To Do", tasks: []),
        KanbanColumn(name: "In Progress", tasks: []),
        KanbanColumn(name: "Done", tasks: [])
    ]

    func addTask(to columnIndex: Int, title: String, description: String) {
        let newTask = KanbanTask(title: title, description: description)
        columns[columnIndex].tasks.append(newTask)
    }

    func deleteTask(from columnIndex: Int, taskID: UUID) {
        columns[columnIndex].tasks.removeAll { $0.id == taskID }
    }

    func updateTask(in columnIndex: Int, taskID: UUID, newTitle: String, newDescription: String) {
        if let index = columns[columnIndex].tasks.firstIndex(where: { $0.id == taskID }) {
            columns[columnIndex].tasks[index].title = newTitle
            columns[columnIndex].tasks[index].description = newDescription
        }
    }

    func moveTask(from sourceColumnIndex: Int, sourceTaskID: UUID, to destinationColumnIndex: Int) {
        if let taskIndex = columns[sourceColumnIndex].tasks.firstIndex(where: { $0.id == sourceTaskID }) {
            let task = columns[sourceColumnIndex].tasks.remove(at: taskIndex)
            columns[destinationColumnIndex].tasks.append(task)
        }
    }
}
