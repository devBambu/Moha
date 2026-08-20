//
//  MohaView.swift
//  Moha
//
//  Created by 변예린 on 8/19/26.
//

import SwiftUI

struct MohaView: View {
    @State private var router = MainRouter()
    
    var body: some View {
        TabView(selection: $router.selectedTab) {
            HomeNavigationStack(router: router.homeRouter)
                .tag(TabItem.home)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            ReportNavigationStack(router: router.reportRouter)
                .tag(TabItem.report)
                .tabItem {
                    Label("Report", systemImage: "chart.xyaxis.line")
                }
            
            SettingsNavigationStack(router: router.settingsRouter)
                .tag(TabItem.settings)
                .tabItem {
                    Label("Settings", systemImage: "person")
                }
        }
        .environment(router)
    }
}

extension MohaView {
    enum TabItem {
        case home
        case report
        case settings
    }
}

//MARK: - MohaView Preview
#Preview {
    MohaView()
}
