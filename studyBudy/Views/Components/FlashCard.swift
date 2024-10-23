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
    var text: String = "Sample Flashcard Text "
    var lineColor: Color = Color.gray.opacity(0.4)
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 35)
                    .fill(backgroundColor)
                    .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
                    .shadow(radius: 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 35)
                            .stroke(borderColor ?? backgroundColor, lineWidth: borderColor != nil ? 2 : 0)
                    )
                    .overlay(
                        VStack(spacing: geometry.size.height * 0.05) {
                            ForEach(0..<8) { _ in
                                Rectangle()
                                    .fill(lineColor)
                                    .frame(height: 1)
                                    .padding(.horizontal, 10)
                            }
                        }
                    )
                
                // Text overlay with improved wrapping
                Text(text)
                    .font(.system(size: min(18, geometry.size.width * 0.05), weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(20)
                    .frame(maxWidth: geometry.size.width * 0.85, maxHeight: geometry.size.height * 0.45)
            }
        }
        .frame(height: 250) // Set a default height for better appearance in previews
    }
}

#Preview {
    FlashCard(text: "Sample Flashcard Text with enough content to show wrapping correctly.")
}
