//
//  ChartsView.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 14/11/24.
//

import SwiftUI
import Charts

struct ChartsView: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(.systemBackground).ignoresSafeArea() // Background color for entire view

                List {
                    Section {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Progreso de Pomodoros")
                                .font(.headline)
                                .padding(.leading, 10)

                            PomodoroMetric(completedPomodoros: 4, totalPomodoros: 5)
                        }
                        .padding()
                        .frame(width: geometry.size.width * (UIDevice.current.userInterfaceIdiom == .pad ? 0.95 : 0.9))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        .padding(.top, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Progreso de Aprendizaje")
                                .font(.headline)
                                .padding(.leading, 10)

                            ExamProgressPieChartView()
                        }
                        .padding()
                        .frame(width: geometry.size.width * (UIDevice.current.userInterfaceIdiom == .pad ? 0.95 : 0.9))
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .scrollContentBackground(.hidden) // Hide default list background
            }
        }
    }
}

#Preview {
    ChartsView()
}
