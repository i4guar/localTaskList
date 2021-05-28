//
//  ContentView.swift
//  LocalTaskList
//
//  Created by Felix Houghton-Larsen on 28.05.21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TaskViewModel()
    var body: some View {
        VStack {
            Toggle(isOn: $viewModel.isFilterEnabled, label: {
                Text("Only numbers less than 3")
            })
            List {
                ForEach(viewModel.filteredTasks) {
                    Text("\($0)")
                }
            }.overlay(Button(action: viewModel.addRandomInt, label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40, alignment: .center)
            })
            .padding(8)
            .background(Color.blue)
            .cornerRadius(15)
            .padding(8)
            .shadow(radius: 3,
                    x: 3,
                    y: 3)
                , alignment: Alignment.bottomTrailing)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: TaskViewModel())
    }
}
