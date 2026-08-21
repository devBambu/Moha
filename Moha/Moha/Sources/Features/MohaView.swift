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
                    Label(TabItem.home.title, systemImage: "house")
                }
            
            ReportNavigationStack(router: router.reportRouter)
                .tag(TabItem.report)
                .tabItem {
                    Label(TabItem.report.title, systemImage: "chart.xyaxis.line")
                }
            
            SettingsNavigationStack(router: router.settingsRouter)
                .tag(TabItem.settings)
                .tabItem {
                    Label(TabItem.settings.title, systemImage: "person")
                }
        }
        .environment(router)
    }
}

//MARK: Tab Item
enum TabItem {
    case home
    case report
    case settings
    
    var title: LocalizedStringResource {
        switch self {
        case .home: "TabItem.home.title"
        case .report: "TabItem.report.title"
        case .settings: "TabItem.settings.title"
        }
    }
}

//MARK: - MohaView Preview
#Preview {
    MohaView()
}
