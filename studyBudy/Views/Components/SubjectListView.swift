import SwiftUI

struct SubjectListView: View {
    @State private var singleSelection: UUID?

    var body: some View {
        List(selection: $singleSelection) {
            ForEach(subjectCategories) { category in
                Section(header: Text("Notas sobre \(category.name)")
                            .font(.headline)
                            .foregroundColor(.gray)) {
                    ForEach(category.subjects) { subject in
                        HStack {
                            Text(subject.name)
                                .font(.body)
                            Spacer()
                            Text("Ver más")
                                .foregroundColor(Color.blue)
                                .font(.callout)
                        }
                        .padding(.vertical, 5)
                    }
                }
                .textCase(nil) // Mantiene el texto del encabezado tal como está
            }
        }
        .listStyle(.plain)
        .padding(.horizontal, 16)
    }
}

