//
//  FlashCard.swift
//  studyBudy
//
//  Created by Maria Renee Ramos Valdez on 23/10/24.
//
//.scrollContentBackground(.hidden)
import SwiftUI

struct FlashCard: View {
    @State var cardVM = CardViewModel()
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
<<<<<<< HEAD
                        )
                        .frame(height: 300)
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
=======
                        }
                    )
                
               
                Text(text)
                    .font(.system(size: min(18, geometry.size.width * 0.05), weight: .medium))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.black)
                    .padding(20)
                    .frame(maxWidth: geometry.size.width * 0.85, maxHeight: geometry.size.height * 0.45)
            }
        }
        .frame(height: 250)
>>>>>>> personal/josealbertoruizr
    }
}

#Preview {
    @Previewable @State var sampleText = "Sample flashcard text"
    FlashCard(text: $sampleText)
}
