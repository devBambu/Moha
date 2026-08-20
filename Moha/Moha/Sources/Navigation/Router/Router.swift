//
//  Router.swift
//  Moha
//
//  Created by 변예린 on 8/20/26.
//

import SwiftUI

protocol Router: AnyObject {
    associatedtype Destination: Route
    
    var path: NavigationPath { get set }
}

extension Router {
    func push(to route: any Route) {
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
    
    func replace(with route: any Route) {
        path = NavigationPath()
        path.append(route)
    }
}

@Observable
final class HomeRouter: Router {
    typealias Destination = HomeRoute
    
    var path = NavigationPath()
}

@Observable
final class ReportRouter: Router {
    typealias Destination = ReportRoute
    
    var path = NavigationPath()
}

@Observable
final class SettingsRouter: Router {
    typealias Destination = SettingsRoute
    
    var path = NavigationPath()
}
