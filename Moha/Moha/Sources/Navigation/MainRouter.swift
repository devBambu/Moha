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
    
    
}
