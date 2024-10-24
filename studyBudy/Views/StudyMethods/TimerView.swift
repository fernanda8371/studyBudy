//
//  TimerView.swift
//  studyBudy
//
//  Created by Maria Castresana on 23/10/24.
//

import SwiftUI

// Enumeración para los diferentes estados del Pomodoro
enum PomodoroState {
    case study
    case shortBreak
    case longBreak
}

struct TimerView: View {
    let studyTime: Int
    let shortBreakTime: Int
    let longBreakTime: Int
    
    @State private var timeRemaining: Int
    @State private var isPaused: Bool = false
    @State private var timer: Timer? = nil
    @State private var currentState: PomodoroState = .study
    @State private var cycleCount: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    init(studyTime: Int, shortBreakTime: Int, longBreakTime: Int) {
        self.studyTime = studyTime
        self.shortBreakTime = shortBreakTime
        self.longBreakTime = longBreakTime
        _timeRemaining = State(initialValue: studyTime)
    }
    
    var stateText: String {
        switch currentState {
        case .study:
            return "Ciclo de Estudio \(cycleCount + 1)/4"
        case .shortBreak:
            return "Break Corto"
        case .longBreak:
            return "Break Largo"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    timer?.invalidate()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                Spacer()
            }
            .padding()
            
            Image("tomato")
                .resizable()
                .frame(width: 100, height: 100)
                .padding(.top)
            
            Text("Metodo Pomodoro")
                .font(.system(size: 60, weight: .bold))
                .fontWeight(.bold)
                .foregroundColor(Color(hex: "#F45151"))
                .padding(.bottom, 50)
            
            Text(stateText)
                .font(.title2)
                .bold()
                .padding(.bottom, 20)
            
            ZStack {
                Circle()
                    .stroke(Color(hex: "#F45151"), lineWidth: 15)
                    .frame(width: 200, height: 200)

                Circle()
                    .trim(from: 0.0, to: CGFloat(timeRemaining) / CGFloat(getCurrentStateTime()))
                    .stroke(Color.red, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 200, height: 200)
                    .animation(.easeInOut(duration: 1), value: timeRemaining)

                Text("\(formatTime(timeRemaining))")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.black)
            }
            .padding(.bottom, 50)

            Button(action: {
                if isPaused {
                    startTimer()
                } else {
                    pauseTimer()
                }
                isPaused.toggle()
            }) {
                Text(isPaused ? "Reanudar" : "Pausar")
                    .font(.title)
                    .bold()
                    .frame(width: 300, height: 60)
                    .background(Color(hex: "#F45151"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)

            Spacer()
        }
        .onAppear {
            startTimer()
        }
    }
    
    func getCurrentStateTime() -> Int {
        switch currentState {
        case .study:
            return studyTime
        case .shortBreak:
            return shortBreakTime
        case .longBreak:
            return longBreakTime
        }
    }
    
    func moveToNextState() {
        switch currentState {
        case .study:
            cycleCount += 1
            if cycleCount == 4 {
                currentState = .longBreak
                timeRemaining = longBreakTime
                cycleCount = 0
            } else {
                currentState = .shortBreak
                timeRemaining = shortBreakTime
            }
        case .shortBreak, .longBreak:
            currentState = .study
            timeRemaining = studyTime
        }
    }
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                moveToNextState()
            }
        }
    }

    func pauseTimer() {
        timer?.invalidate()
    }

    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(studyTime: 1500, shortBreakTime: 300, longBreakTime: 900)
    }
}






