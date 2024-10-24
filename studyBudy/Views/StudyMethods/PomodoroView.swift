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
        VStack {
            Spacer()
            HStack {

                Spacer()
            }
            .padding(.horizontal)
            
            Image("tomato")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top)
            
            Text("Metodo Pomodoro")
                .font(.system(size: 60, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#F45151"))
                .padding(.bottom, 30)
            
            VStack {
                Text("Tiempo de estudio:")
                    .font(.system(size: 30, weight: .semibold))
                HStack {
                    Text("\(studyTime / 60) min")
                        .font(.largeTitle)
                        .bold()
                    Stepper("", value: $studyTime, in: 5 * 60...60 * 60, step: 60)
                        .labelsHidden()
                }
            }
            .padding()
            
            VStack {
                Text("Break corto:")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.top, 30)
                HStack {
                    Text("\(shortBreak / 60) min")
                        .font(.largeTitle)
                        .bold()
                    Stepper("", value: $shortBreak, in: 5 * 60...30 * 60, step: 60)
                        .labelsHidden()
                }
            }
            .padding()

            VStack {
                Text("Break largo:")
                    .font(.system(size: 30, weight: .semibold))
                    .padding(.top, 30)
                HStack {
                    Text("\(longBreak / 60) min")
                        .font(.largeTitle)
                        .bold()
                    Stepper("", value: $longBreak, in: 5 * 60...60 * 60, step: 60)
                        .labelsHidden()
                }
            }
            .padding()

            Button(action: {
                showTimerView.toggle()
            }) {
                Text("Iniciar Temporizador")
                    .font(.title)
                    .bold()
                    .frame(width: 500, height: 80)
                    .background(Color(hex: "#F45151"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 160)
            .fullScreenCover(isPresented: $showTimerView) {
                TimerView(studyTime: studyTime, shortBreakTime: shortBreak, longBreakTime: longBreak)
            }

            Spacer()
        }
        .padding()
    }
}

struct PomodoroView_Previews: PreviewProvider {
    static var previews: some View {
        PomodoroView()
    }
}



