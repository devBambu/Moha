//
//  MohaView.swift
//  Moha
//
//  Created by 변예린 on 8/19/26.
//

import SwiftUI

struct MohaView: View {
    @State private var selectedTab: TabItem = .report
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Text("Home")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(TabItem.home)
            
            Text("Report")
                .tabItem {
                    Label("Report", systemImage: "chart.xyaxis.line")
                }
                .tag(TabItem.report)
            
            Text("My Page")
                .tabItem {
                    Label("Settings", systemImage: "person")
                }
                .tag(TabItem.settings)
        }
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
