//
//  ContentView.swift
//  Study0224
//
//  Created by r on 2022/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isReady = false
    @State private var username = ""
    
    @State private var counter: Int = 0
    @State private var counterx: Int = 0
    
    @State private var counterz: Int = 0
    
    let lemonYellow = Color(red: 0.4627, green: 0.8392, blue: 1.0)
    
    var body: some View {
         
        VStack(alignment: .leading){
            
            Text(username)
            if(self.username.count >= 6) {
                Text("\(self.username.count)")
            }
            
            TextField("Username", text: $username)
               
                .foregroundColor(Color.blue)

            Button(action: {
                print ("tapped!")
                self.isReady.toggle()
                self.username = ""
               
            }, label: { Text("Tap Me") })
                .disabled(self.username.count == 0)
 
            
            Toggle(isOn: $isReady,
                   label: {
                    Text("Ready: " + (isReady ? "Yes" : "No"))
            })
            
            
            Stepper(onIncrement: {
                self.counter += 1
            }, onDecrement: {
                self.counter -= 1;
            }){
                Text.init("\(counter)")
            }
            
            Stepper("\(counterx)", value: $counterx, in: 0...9)
            
            MyStepper(counterz: $counterz)

           Spacer()
        }
        .padding([.leading, .trailing], 30.0)
        
    }
}
