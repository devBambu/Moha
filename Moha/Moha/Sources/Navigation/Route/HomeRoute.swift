//
//  HomeRoute.swift
//  Moha
//
//  Created by 변예린 on 8/20/26.
//

enum HomeRoute: Route {
    case createTodo
    
    var id: String {
        switch self {
        case .createTodo: "createTodo"
        }
    }
}
