//
//  PomodoroMetric.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 14/11/24.
//

import SwiftUI
import Charts

struct PomodoroMetric: View {
    let completedPomodoros: Int
    let totalPomodoros: Int
    
    var remainingPomodoros: Int {
        max(totalPomodoros - completedPomodoros, 0)
    }

    var data: [(type: String, amount: Double)] {
        [
            (type: "Completed", amount: Double(completedPomodoros)),
            (type: "Remaining", amount: Double(remainingPomodoros))
        ]
    }
    
    var body: some View {
            VStack(alignment: .center, spacing: 20) {
                Text("Progreso de Pomodoros")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.primary)
                    .padding(.top, 10)
                
                HStack(spacing: 20) { // Spacing between chart and labels
                    // Chart
                    Chart(data, id: \.type) { dataItem in
                        SectorMark(
                            angle: .value("Pomodoros", dataItem.amount),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .foregroundStyle(color(for: dataItem.type))
                        .cornerRadius(5)
                    }
                    .frame(width: 120, height: 120) // Adjusted for a compact, balanced look
                    
                    // Status Labels
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Circle()
                                .fill(color(for: "Completed"))
                                .frame(width: 12, height: 12)
                            Text("Completos: \(completedPomodoros)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                        HStack {
                            Circle()
                                .fill(color(for: "Remaining"))
                                .frame(width: 12, height: 12)
                            Text("Pausados: \(remainingPomodoros)")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .padding()

        }

    func color(for type: String) -> Color {
        switch type {
        case "Completed":
            return Color.green
        case "Remaining":
            return Color.pink
        default:
            return Color.gray
        }
    }
}

#Preview {
    PomodoroMetric(completedPomodoros: 3, totalPomodoros: 8)
}
