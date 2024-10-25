//
//  PomodoroView.swift
//  studyBudy
//
//  Created by Maria Castresana on 23/10/24.
//

import SwiftUI

struct PomodoroView: View {
    @State private var studyTime: Int = 25 * 60
    @State private var shortBreak: Int = 5 * 60
    @State private var longBreak: Int = 15 * 60
    @State private var showTimerView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center, spacing: 20) { // Espaciado global entre elementos
                Spacer()
                
                Image("tomato")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.top, 20)
                
                Text("Metodo Pomodoro")
                    .font(.system(size: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 32, weight: .bold))
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "#F45151"))
                    .padding(.bottom, 20)
                
                // Tiempo de estudio
                VStack {
                    Text("Tiempo de estudio:")
                        .font(.system(size: 25, weight: .semibold))
                    HStack {
                        Text("\(studyTime / 60) min")
                            .font(.largeTitle)
                            .bold()
                        Stepper("", value: $studyTime, in: 5 * 60...60 * 60, step: 60)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, 20)
                
                // Break corto
                VStack {
                    Text("Break corto:")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.top, 10)
                    HStack {
                        Text("\(shortBreak / 60) min")
                            .font(.largeTitle)
                            .bold()
                        Stepper("", value: $shortBreak, in: 5 * 60...30 * 60, step: 60)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, 20)

                // Break largo
                VStack {
                    Text("Break largo:")
                        .font(.system(size: 25, weight: .semibold))
                        .padding(.top, 10)
                    HStack {
                        Text("\(longBreak / 60) min")
                            .font(.largeTitle)
                            .bold()
                        Stepper("", value: $longBreak, in: 5 * 60...60 * 60, step: 60)
                            .labelsHidden()
                    }
                }
                .padding(.horizontal, 20)

                // Botón de iniciar temporizador
                Button(action: {
                    showTimerView.toggle()
                }) {
                    Text("Iniciar Temporizador")
                        .font(.title2)
                        .bold()
                        .frame(width: geometry.size.width * 0.8, height: 60)
                        .background(Color(hex: "#F45151"))
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.top, 30)
                .fullScreenCover(isPresented: $showTimerView) {
                    TimerView(studyTime: studyTime, shortBreakTime: shortBreak, longBreakTime: longBreak)
                }
                
                Spacer()
            }
            .frame(width: geometry.size.width, alignment: .center)
            .padding(.horizontal, 0)
        }
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}



