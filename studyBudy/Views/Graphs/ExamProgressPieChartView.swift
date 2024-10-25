import SwiftUI
import Charts

//class ExamProgressViewModel: ObservableObject {
//    @Published var totalProgressPerSection: [ExamSectionData] = []
//    var bestPerformingSection: ExamSectionData? {
//        totalProgressPerSection.max(by: { $0.progress < $1.progress })
//    }
//
//    // Example static preview data
//    static var preview: ExamProgressViewModel {
//        let viewModel = ExamProgressViewModel()
//
//        // Declare the sections properly
//        let math = "Math"
//        let english = "English"
//        let science = "Science"
//
//        viewModel.totalProgressPerSection = [
//            ExamSectionData(section: ExamSection(math), progress: 85),
//            ExamSectionData(section: ExamSection(english), progress: 70),
//            ExamSectionData(section: ExamSection(science), progress: 95)
//        ]
//        return viewModel
//    }
//}
//
//struct ExamSectionData {
//    var section: ExamSection
//    var progress: Double
//}
//
//struct ExamSection: Hashable {
//    var displayName: String
//
//    init(_ name: String) {
//        self.displayName = name
//    }
//}


struct ExamProgressPieChartView: View {
    
    let caseDistribution: [String: Double] = [
        "Civil": 40,
        "Criminal": 20,
        "Family": 10,
        "Commercial": 30
    ]
    
    var body: some View {
        HStack {
            // Title for the chart
            Text("Distribución de Tipos de Casos Legales")
                .font(.headline)
                .padding(.bottom, 10)
            
            if #available(iOS 16.0, *) {
                // Donut chart
                Chart(caseDistribution.sorted(by: { $0.key < $1.key }), id: \.key) { caseType, percentage in
                    SectorMark(
                        angle: .value("Cases", percentage),
                        innerRadius: .ratio(0.5), // Create the donut effect
                        angularInset: 1.5
                    )
                    .foregroundStyle(by: .value("Case Type", caseType))
                }
                .aspectRatio(1, contentMode: .fit)
                .chartLegend(.hidden)
            }
        }
        .padding()
    }
}



#Preview {
    ExamProgressPieChartView()
}

