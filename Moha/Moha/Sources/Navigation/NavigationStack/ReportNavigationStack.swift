//
//  ReportNavigationStack.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct ReportNavigationStack: View {
    @Bindable var router: ReportRouter
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Text("Report") //TODO: ReportView로 수정 필요
                .navigationDestination(for: ReportRoute.self) { route in
                    destinationView(for: route)
                }
        }
    }
    
    @ViewBuilder
    private func destinationView(for route: ReportRoute) -> some View {
        switch route {
        case .createTodo:
        }
    }
}
