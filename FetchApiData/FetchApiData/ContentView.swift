//
//  ContentView.swift
//  FetchApiData
//
//  Created by mac on 2022/1/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var fetch = FetchUsers()
    
    var body: some View {
        if (fetch.items.count == 0) {
            ProgressView().onAppear {
                fetch.loadData()
            }
        } else {
            List (fetch.items, id: \.login) {user in
                Link(destination: URL(string: user.html_url)!) {
                    HStack {
                        AsyncImage(url: URL(string: user.avatar_url), scale: 5.0)
                        VStack (alignment: .leading) {
                            Text(user.login)
                            Text("\(user.url)")
                                .font(.system(size: 11))
                                .foregroundColor(Color.gray)
                            Text(user.avatar_url)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Result: Codable {
    var items: [User]
}

struct User: Codable {
    public var login: String
    public var url: String
    public var avatar_url: String
    public var html_url: String
}
