//
//  Router.swift
//  Moha
//
//  Created by 변예린 on 8/20/26.
//

import SwiftUI

protocol NavigationRouter: AnyObject {
    associatedtype Destination: Route
    
    var path: NavigationPath { get set }
}

extension NavigationRouter {
    func push(to route: Destination) {
        path.append(route)
    }
    
    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    func reset() {
        path = NavigationPath()
    }
    
    func popTo(count: Int) {
        guard count > 0, count <= path.count else { return }
        path.removeLast(count)
    }
    
    func replace(with route: Destination) {
        path = NavigationPath()
        path.append(route)
    }
}

@Observable
final class PlanRouter: NavigationRouter {
    typealias Destination = PlanRoute
    
    var path = NavigationPath()
}

@Observable
final class ReportRouter: NavigationRouter {
    typealias Destination = ReportRoute
    
    var path = NavigationPath()
}

@Observable
final class SettingsRouter: NavigationRouter {
    typealias Destination = SettingsRoute
    
    var path = NavigationPath()
}
