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
import Combine

protocol ClockModelProtocol{
    var hours: String { set get}
    var minutes: String {set get}
    var seconds: String {set get}
    
    mutating func update()
}

class ClockVM: ObservableObject {
    @Published var hours = "00"
    @Published var minutes = "00"
    @Published var seconds = "00"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink{ _ in
                self.update()
            }
            .store(in: &cancellables)
    }
        func update(){
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


//Modify behavior without changing the code (OCP)
struct ClockView: View {
    @ObservedObject var vm: ClockVM
        
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
    }
}

struct ContentView: View {
    @StateObject var vm = ClockVM()
    var body: some View {
        VStack {
            ClockView(vm: vm)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}










//
//struct ClockModel: ClockModelProtocol {
//    var hours = "01"
//    var minutes = "00"
//    var seconds = "00"
//
//    mutating func update(){
//        let date = Date()
//        let calendar = Calendar.current
//
//        let hour = calendar.component(.hour, from: date)
//        let minute = calendar.component(.minute, from: date)
//        let second = calendar.component(.second, from: date)
//
//        self.hours = String(format: "%02d", hour)
//        self.minutes = String(format: "%02d", minute)
//        self.seconds = String(format: "%02d", second)
//    }
//}
//
//struct ClockModelTwo: ClockModelProtocol {
//    var hours = "01"
//    var minutes = "00"
//    var seconds = "00"
//
//    mutating func update(){
//        let date = Date()
//        let calendar = Calendar.current
//
//        let hour = calendar.component(.hour, from: date)
//        let minute = calendar.component(.minute, from: date)
//        let second = calendar.component(.second, from: date)
//
//        self.hours = String(format: "%02d", hour)
//        self.minutes = String(format: "%02d", minute)
//        self.seconds = String(format: "%02d", second)
//    }
//}
