//
//  ContentView.swift
//  Todo List
//
//  Created by mac on 2021/12/25.
//

import SwiftUI

struct ContentView: View {
    @State private var todos = [
        Todo(name: "coding...", category: "desktopcomputer"),
        Todo(name: "健身", category: "house"),
        Todo(name: "相亲", category: "theatermasks")
    ]

    @State private var showAddTodoView = false // 默认为 false，不跳转AddTodoView`
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos, id:\.name) { (todo) in
                    NavigationLink(destination: {
                        VStack {
                            Text(todo.name)
                            Image(systemName: todo.category)
                                .resizable()
                                .frame(width: 200, height: 200)
                        }
                    }) {
                        HStack {
                            Image(systemName: todo.category)
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(todo.name)
                        }
                    }
                }.onDelete(perform: {indexSet in
                    todos.remove(atOffsets: indexSet)
                })
                .onMove(perform: {indices, newOffset in
                    todos.move(fromOffsets: indices, toOffset: newOffset)
                })
            }.navigationTitle("土豆List")
            .navigationBarItems(
                leading: Button(action: {
                                    // 反转 showAddTodoView 的值，false => true
                                    self.showAddTodoView.toggle()
                                },
                                label: {
                                    Text("+1")
                                }).sheet(isPresented: $showAddTodoView) {
                                    AddTodoView(showAddTodoView: self.$showAddTodoView, todos: self.$todos)
                                },
                trailing: EditButton()
            )
        }
    }
    
    // 增加一条 todo记录的函数
    func addTodo() {
        todos.append(Todo(name: "新的Todo", category: "desktopcomputer"))
    }
}

struct Todo: Identifiable { // 遵守 Identifiable 协议
    let id = UUID() // 新加一个 id 属性
    let name: String
    let category: String
}


// 增加新 todo记录的页面
struct AddTodoView: View {
    // @Binding 的作用下面马上会解释
    @Binding var showAddTodoView: Bool
    
    @State private var name: String = ""
    // 用户选择了 categoryTypes中的某一项后，该变量为其索引值
    @State private var selectedCategory = 0
    // 存放预先定义的玄功选择的 category，展示在选择器 picker中
    var categoryTypes = ["house", "theatermasks", "desktopcomputer"]
    
    @Binding var todos: [Todo] // Todo类型的数组，用于接收其它地方传入参数
    
    var body: some View {
        Text("增加 todo")
        TextField("name", text: $name)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .border(Color.black)
            .padding()
        
        Text("选择 category")
        Picker("", selection: $selectedCategory) {
            ForEach(0 ..< categoryTypes.count) {
                // $0 表示取第一个参数
                Text(self.categoryTypes[$0])
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        
        Button(action: {
            self.showAddTodoView = false // 隐藏 sheet
            // 新建一个 Todo并添加到 todos数组中
            todos.append(Todo(name: name,
                             category: categoryTypes[selectedCategory]))
        }, label: {
            Text("点击新建")
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
