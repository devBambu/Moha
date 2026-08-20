//
//  HomeNavigationStack.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct HomeNavigationStack: View {
    @Bindable var router: HomeRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Text("Home") //TODO: HomeView로 수정 필요
                .navigationDestination(for: HomeRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }
    
    @ViewBuilder
    private func destinationView(for route: HomeRoute) -> some View {
        switch route {
        case .createTodo:
            Text("Create")
        }
    }
}
