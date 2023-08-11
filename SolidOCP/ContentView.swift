//
//  ContentView.swift
//  SolidOCP
//
//  Created by luis armendariz on 8/1/23.
//
/*
 Open Closed Principle
 "Software entities (classes, modules, functions, etc.) should be open for extension but closed for modification."

 Dependency Injection
 1. Struct Protocol (Model View Architecture)
 2. Class observableObject Inheritance vs Protocol, MVVM Architecture
 
 */


import SwiftUI

struct ClockModel {
    var hours = "01"
    var minutes = "00"
    var seconds = "00"
    
    mutating func update(){
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        
        self.hours = String(format: "%02d", hour)
        self.minutes = String(format: "%02d", minute)
        self.seconds = String(format: "%02d", second)
    }
}

struct ClockView: View {
    @State var vm: ClockModel
    
    let timer = Timer.TimerPublisher(interval: 1, runLoop: .main, mode: .common).autoconnect()
    var body: some View{
        HStack{
            Text(vm.hours)
            Text(":")
            Text(vm.minutes)
            Text(":")
            Text(vm.seconds)
        }
        .font(.largeTitle)
        .monospacedDigit()
        .onReceive(timer){_ in
            vm.update()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            ClockView(vm: ClockModel())
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
