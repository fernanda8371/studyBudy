//
//  Button.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//

import SwiftUI

struct Boton: View {
    var title: String
    var backgroundColor: Color
    var textColor: Color
    var borderColor: Color? = nil
    var width: CGFloat = 500
    var height: CGFloat = 60
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .frame(width: width, height: height)
                .padding()
                .background(backgroundColor)
                .cornerRadius(55)
                .foregroundColor(textColor)
                .overlay(
                    RoundedRectangle(cornerRadius: 55)
                        .stroke(borderColor ?? backgroundColor, lineWidth: borderColor != nil ? 2 : 0)
                )
        }
    }
}



#Preview {
    Boton(
            title: "Ejemplo",
            backgroundColor: .blue,
            textColor: .white,
            borderColor: .white,
            action: {
                // Acción del botón (puede estar vacío para la vista previa)
            }
        )
}
