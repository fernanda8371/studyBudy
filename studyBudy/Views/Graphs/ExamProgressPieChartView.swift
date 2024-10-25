import SwiftUI
import Charts
import Combine

class ExamProgressViewModel: ObservableObject {
    @Published var totalProgressPerSection: [ExamSectionData] = []

    var bestPerformingSection: ExamSectionData? {
        totalProgressPerSection.max(by: { $0.progress < $1.progress })
    }
    
    // Example static preview data
    static var preview: ExamProgressViewModel {
        let viewModel = ExamProgressViewModel()
        
        let math = "Math"
        let english = "English"
        let science = "Science"
        
        viewModel.totalProgressPerSection = [
            ExamSectionData(section: ExamSection(math), progress: 85),
            ExamSectionData(section: ExamSection(english), progress: 70),
            ExamSectionData(section: ExamSection(science), progress: 95)
        ]
        return viewModel
    }
    
    // Method to add new progress data
    func addProgress(sectionName: String, progress: Double) {
        // Check if the section already exists in the progress data
        if let index = totalProgressPerSection.firstIndex(where: { $0.section.displayName == sectionName }) {
            // Update the existing section's progress
            totalProgressPerSection[index].progress = progress
        } else {
            // Add a new section if it doesn't exist
            let newSection = ExamSectionData(section: ExamSection(sectionName), progress: progress)
            totalProgressPerSection.append(newSection)
        }
    }
}

struct ExamSectionData {
    var section: ExamSection
    var progress: Double
}

struct ExamSection: Hashable {
    var displayName: String
    
    init(_ name: String) {
        self.displayName = name
    }
}

@available(iOS 16.0, *)
struct ExamProgressPieChartView: View {
    @ObservedObject var examViewModel: ExamProgressViewModel
    
    var body: some View {
        VStack {
            // Title for the chart
            Text("Progress by Section")
                .font(.headline)
                .padding(.bottom, 10)
            
            if examViewModel.totalProgressPerSection.isEmpty {
                Text("No progress data available")
                    .foregroundColor(.gray)
                    .padding()
            } else {
                // Donut chart for exam progress
                Chart(examViewModel.totalProgressPerSection, id: \.section) { data in
                    SectorMark(
                        angle: .value("Progress", data.progress),
                        innerRadius: .ratio(0.5),  // Donut effect
                        angularInset: 1.5
                    )
                    .cornerRadius(5.0)
                    .foregroundStyle(by: .value("Section", data.section.displayName))
                    .opacity(data.section == examViewModel.bestPerformingSection?.section ? 1 : 0.5)
                }
                .aspectRatio(1, contentMode: .fit)
                .chartLegend(.hidden) // Hide the default legend for a cleaner look
                .padding()
                
                // Display the best-performing section inside the chart
                if let bestPerformingSection = examViewModel.bestPerformingSection {
                    VStack {
                        Text("Top Section")
                            .font(.callout)
                            .foregroundColor(.secondary)
                        Text(bestPerformingSection.section.displayName)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        Text("\(Int(bestPerformingSection.progress))% completed")
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}

@available(iOS 16.0, *)
#Preview {
    ExamProgressPieChartView(examViewModel: .preview)
}
