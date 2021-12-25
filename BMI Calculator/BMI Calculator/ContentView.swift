//
//  ContentView.swift
//  BMI Calculator
//
//  Created by mac on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    @State private var weightText: String = ""
    @State private var heightText: String = ""
    @State private var bmi: Double = 0
    @State private var classification: String = ""
    
    var body: some View {
        VStack {
            Text("BMI计算器").font(.largeTitle)
            TextField("体重(kg)", text: $weightText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("身高(m)", text: $heightText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.black)
            
            Button(action: {
                let weight = Double(self.weightText)!
                let height = Double(self.heightText)!
                self.bmi = weight/(height * height)
                
                if self.bmi < 18.5 {
                    self.classification = "过轻"
                } else if self.bmi < 24.9 {
                    self.classification = "健康"
                } else if self.bmi < 29.9 {
                    self.classification = "超重"
                } else {
                    self.classification = "肥胖"
                }
            }) {
                Text("计算BMI")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
            }
            
            Text("BMI: \(bmi, specifier: "%.1f"), \(classification)").font(.title).padding()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
