//
//  ContentView.swift
//  PomodoroTimer
//
//  Created by Kastro on 30/5/23.
//

import SwiftUI

struct ContentView: View {
    @State private var timer: Timer?
    @State private var timeRemaining: TimeInterval = 1500
    @State private var isTimerRunning = false

    let timerInterval: TimeInterval = 1
    let workTime: TimeInterval = 1500
    
    var body: some View {
        VStack {
            Text("Pomodoro Timer")
                .font(.largeTitle)
                .padding()
            
            Text(timeFormatter(timeRemaining))
                .font(.system(size: 60, weight: .bold, design: .rounded))
                .padding()
            
            HStack(spacing: 20) {
                Button(action: startTimer) {
                    Text("Start")
                }
                .disabled(isTimerRunning)
                
                Button(action: stopTimer) {
                    Text("Stop")
                }
                .disabled(!isTimerRunning)
                
                Button(action: resetTimer) {
                    Text("Reset")
                }
                .disabled(isTimerRunning)
            }.padding()
        }.frame(width: 400, height: 200)
    }
    
    func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: timerInterval, repeats: true, block: { _ in
            if timeRemaining > 0 {
                timeRemaining -= timerInterval
            } else {
                stopTimer()
            }
        })
    }
    
    func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetTimer() {
        timeRemaining = workTime
    }
    
    func timeFormatter(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}
