//
//  FlashCard.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//
//.scrollContentBackground(.hidden)
import SwiftUI

struct FlashCard: View {
    var backgroundColor: Color = Color.white
    var borderColor: Color? = nil
    var lineColor: Color = Color.gray.opacity(0.4)
    @Binding var text: String
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    RoundedRectangle(cornerRadius: 35)
                        .fill(backgroundColor)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
                        .shadow(radius: 5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 35)
                                .stroke(borderColor ?? backgroundColor, lineWidth: borderColor != nil ? 2 : 0)
                        )
                        .overlay(

                            ZStack {
                                // Create lines
                                VStack(spacing: 10) {
                                    Spacer()
                                    ForEach(0..<12) { _ in
                                        Rectangle()
                                            .fill(lineColor)
                                            .frame(height: 1)
                                            .padding(.horizontal, 15)
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 10)
                                
                                // Scrollable Text overlay
                                TextEditor(text: $text)
                                    .scrollContentBackground(.hidden)
                                    .lineSpacing(10)
                                    .padding(30)
                                    .font(.system(size: 30, weight: .medium, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .opacity(0.9)
                                
                            }
                        )
                        .frame(height: 300)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

#Preview {
    @Previewable @State var sampleText = "Sample flashcard text"
    FlashCard(text: $sampleText)
}
