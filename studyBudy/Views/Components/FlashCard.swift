//
//  FlashCard.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//

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
                                .padding(.vertical, 20)
                                
                                // Scrollable Text overlay
                                ScrollView {
                                    Text(text)
                                        .lineSpacing(10)
                                        .padding(30)
                                        .font(.system(size: 30))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.leading)
                                        .frame(maxWidth: geometry.size.width * 0.85, alignment: .leading)
                                }
                                .frame(width: geometry.size.width * 0.85, height: geometry.size.height * 0.45)
                                .background(Color.clear)
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
