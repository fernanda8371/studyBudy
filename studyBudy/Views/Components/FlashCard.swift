//
//  FlashCard.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//

import SwiftUI

struct FlashCard: View {
    @Binding var text: String
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 35)
                        .fill(Color.white)
                        .frame(width: geometry.size.width * 0.9, height: 500)
                        .shadow(radius: 5)
                        .overlay(
                            ZStack {
                                // Create lines
                                VStack(spacing: 15) {
                                    ForEach(0..<12) { _ in
                                        Rectangle()
                                            .fill(Color.gray.opacity(0.4))
                                            .frame(height: 1)
                                            .padding(.horizontal, 15)
                                        Spacer()
                                    }
                                }
                                .padding(.vertical, 10)
                                
                                // TextEditor for input
                                TextEditor(text: $text)
                                    .scrollContentBackground(.hidden)
                                    .lineSpacing(15)
                                    .padding(.horizontal, 30)
                                    .padding(.top, 10)
                                    .font(.system(size: 25, weight: .medium, design: .rounded))
                                    .foregroundColor(.black)
                                    .multilineTextAlignment(.leading)
                                    .frame(width: geometry.size.width * 0.85, height: 500)
                            }
                        )
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 500)
        }
    }
}

#Preview {
    @Previewable @State var sampleText = "Sample flashcard text"
    FlashCard(text: $sampleText)
}
