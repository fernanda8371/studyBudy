import SwiftUI
import Charts

class ExamProgressViewModel: ObservableObject {
    @Published var totalProgressPerSection: [ExamSectionData] = []
    var bestPerformingSection: ExamSectionData? {
        totalProgressPerSection.max(by: { $0.progress < $1.progress })
    }
    
    // Example static preview data
    static var preview: ExamProgressViewModel {
        let viewModel = ExamProgressViewModel()
        
        // Declare the sections properly
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

@available(macOS 14.0, *)
struct ExamProgressPieChartView: View {
    
    @ObservedObject var examViewModel: ExamProgressViewModel
    
    var body: some View {
        
        Chart(examViewModel.totalProgressPerSection, id: \.section) { data in
            SectorMark(
                angle: .value("Progress", data.progress),
                innerRadius: .ratio(0.618),  // Donut effect
                angularInset: 1.5
            )
            .cornerRadius(5.0)
            .foregroundStyle(by: .value("Section", data.section.displayName))
            .opacity(data.section == examViewModel.bestPerformingSection?.section ? 1 : 0.3)
        }
        .chartLegend(alignment: .center, spacing: 18)
        .aspectRatio(1, contentMode: .fit)
        
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                
                if let bestPerformingSection = examViewModel.bestPerformingSection {
                    VStack {
                        Text("Best Performing Section")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        Text(bestPerformingSection.section.displayName)
                            .font(.title2.bold())
                            .foregroundColor(.primary)
                        Text("\(Int(bestPerformingSection.progress))% completed")
                            .font(.callout)
                            .foregroundStyle(.secondary)
                    }
                    .position(x: frame.midX, y: frame.midY)
                }
            }
        }
    }
}

@available(macOS 14.0, *)
#Preview {
    ExamProgressPieChartView(examViewModel: .preview)
}

