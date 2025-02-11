//
//  KanbanTaskView.swift
//  IKIGAI
//
//  Created by Anuar Sultanbekov on 11.02.2025.
//

import SwiftUI

struct KanbanTaskView: View {
    var task: KanbanTask
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(task.title)
                .font(.headline)
            Text(task.description)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
