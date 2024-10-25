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

struct ExamProgressPieChartView: View {
    
    let progressDistribution: [String: Double] = [
        "Math": 85,
        "English": 70,
        "Science": 95
    ]
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            // Título para la gráfica
            Text("Progreso de Aprendizaje")
                .font(.title2)
                .bold()
                .foregroundColor(.primary)
                .padding(.top, 10)
            
            HStack(alignment: .top, spacing: 30) {
                // Sección de la leyenda con el detalle del progreso
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(progressDistribution.sorted(by: { $0.key < $1.key }), id: \.key) { section, progress in
                        HStack {
                            Circle()
                                .fill(color(for: section))
                                .frame(width: 12, height: 12)
                            
                            Text("\(section): \(Int(progress))%")
                                .font(.subheadline)
                                .foregroundColor(.primary)
                                .bold()
                        }
                    }
                }
                
                // Gráfica tipo donut con un radio interno para el efecto de anillo
                if #available(iOS 16.0, *) {
                    Chart(progressDistribution.sorted(by: { $0.key < $1.key }), id: \.key) { section, progress in
                        SectorMark(
                            angle: .value("Progreso", progress),
                            innerRadius: .ratio(0.5), // Donut effect
                            angularInset: 1.5
                        )
                        .foregroundStyle(color(for: section))
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .frame(maxWidth: 200)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding()
        
        .padding(.horizontal)
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
}



#Preview {
    ExamProgressPieChartView()
}

