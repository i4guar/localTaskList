//
//  TaskViewModel.swift
//  LocalTaskList
//
//  Created by Felix Houghton-Larsen on 28.05.21.
//

import Foundation
import Combine

class TaskViewModel: ObservableObject {
    @Published var filteredTasks = [Int]()
    @Published var tasks = [Int]()
    @Published var isFilterEnabled: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        $tasks.combineLatest($isFilterEnabled) {
            tasks, isFilterEnabled -> [Int] in
            if isFilterEnabled {
                return tasks.filter { $0 < 3 }
            }
            return tasks
        }
        .receive(on: RunLoop.main)
        .assign(to: \.filteredTasks, on: self)
        .store(in: &cancellables)
    }

    func addRandomInt() {
        tasks.append(Int.random(in: 1..<10))
    }
}

extension Int: Identifiable {
    public var id: String {
        String(self)
    }
}
