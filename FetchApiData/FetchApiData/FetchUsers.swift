//
//  FetchUsers.swift
//  FetchApiData
//
//  Created by mac on 2022/1/15.
//

import Foundation

class FetchUsers: ObservableObject {
    @Published
    var items = [User]()
    
    func loadData() {
        let url = URL(string: "https://api.github.com/search/users?q=ligangs")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            do {
                if let data = data {
                    let decodedData = try JSONDecoder().decode(Result.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.items = decodedData.items
                    }
                } else {
                    print("找不到数据哦😯~")
                }
            } catch {
                print("出错啦：\(error.localizedDescription)")
            }
        }.resume()
    }
}
