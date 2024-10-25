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

import SwiftUI
import Charts

struct ExamProgressPieChartView: View {
    
    let progressDistribution: [String: Double] = [
        "Math": 85,
        "English": 70,
        "Science": 95
    ]
    
    var body: some View {
        VStack {
            // Title for the chart
            Text("Progreso de aprendizaje")
                .font(.title3)
                .foregroundColor(.black) // Color blanco para el texto
                .padding(.bottom, 10)
            HStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(progressDistribution.sorted(by: { $0.key < $1.key }), id: \.key) { section, progress in
                        Text("\(section): \(Int(progress))%")
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(.black)
                    }
                }
                
                if #available(iOS 16.0, *) {
                    Chart(progressDistribution.sorted(by: { $0.key < $1.key }), id: \.key) { section, progress in
                        SectorMark(
                            angle: .value("Progreso", progress),
                            innerRadius: .ratio(0.5),
                            angularInset: 1.5
                        )
                        .foregroundStyle(color(for: section))
                    }
                    .aspectRatio(1, contentMode: .fit)
                }
            }
        }
        .padding()
    }
}
    // Helper function for lighter colors
    func color(for subject: String) -> Color {
        switch subject {
        case "Math":
               return Color(hex: "FFC107") // Strong yellow for Math
           case "English":
               return Color(hex: "2196F3") // Strong blue for English
           case "Science":
            return Color(hex: "4CAF50")
                    
        default:
            return Color.gray
        }
}

// Helper extension to use hex color codes in SwiftUI


#Preview {
    ExamProgressPieChartView()
}

