//
//  MainRouter.swift
//  Moha
//
//  Created by 변예린 on 8/20/26.
//

import SwiftUI
import Combine

final class MainRouter: ObservableObject {
    var selectedTab = MohaView.TabItem.home
    
    let homeRouter = HomeRouter()
    let reportRouter = ReportRouter()
    let myPageRouter = myPageRouter()
    
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
