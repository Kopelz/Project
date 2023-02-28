//
//  Model.swift
//  MyTableApp
//
//  Created by Nikita Gavrilov on 22.02.2023.
//

import Foundation

struct Task {
    let taskText: String
    let week: Week
}

enum Week {
    case Monday, Thursday, Wednesday, Tuesday, Friday, Saturday, Sunday
}

class Sourse {
    
    static func makeTasks() -> [Task] {
        [
            .init(taskText: "Clean car", week: .Monday),
            .init(taskText: "Clean sofa", week: .Monday),
            .init(taskText: "Run 10 km", week: .Monday),
            .init(taskText: "Shopping", week: .Monday),
            
            .init(taskText: "Wake up 8 a.m", week: .Saturday),
            .init(taskText: "Run 5 km", week: .Saturday),
            
            .init(taskText: "Wake up 8 a.m", week: .Tuesday),
            .init(taskText: "Run 5 km", week: .Tuesday),
            .init(taskText: "Get salary on bank", week: .Tuesday),
            .init(taskText: "Sleep 9 p.m", week: .Tuesday)
        ]
    }
    
    static func createGroup() -> [[Task]] {
        let monday = makeTasks().filter { $0.week == .Monday }
        let tuesday = makeTasks().filter { $0.week == .Tuesday }
        let wednesday = makeTasks().filter { $0.week == .Wednesday }
        let thursday = makeTasks().filter { $0.week == .Thursday }
        let friday = makeTasks().filter { $0.week == .Friday }
        let saturday = makeTasks().filter { $0.week == .Saturday }
        let sunday = makeTasks().filter { $0.week == .Sunday }
        return [monday, tuesday, wednesday, thursday, friday, saturday, sunday]
    }
}


