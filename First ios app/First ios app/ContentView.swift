//
//  ContentView.swift
//  First ios app
//
//  Created by mac on 2021/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, 我在[公众号：Swift零一]等你")
                .padding()
            Button("收到👌🏻") {
                print("用户点击了按钮")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
