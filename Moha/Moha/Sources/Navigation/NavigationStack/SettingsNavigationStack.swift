//
//  SettingsNavigationStack.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct SettingsNavigationStack: View {
    @Bindable var router: SettingsRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Text("Settings") //TODO: SettingsView로 수정 필요
                .navigationDestination(for: SettingsRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }
    
    @ViewBuilder
    private func destinationView(for route: SettingsRoute) -> some View {
        switch route {
        case .createTodo:
        }
    }
}
