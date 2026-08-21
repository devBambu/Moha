//
//  PlanView.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct PlanView: View {
    @State var isCalendarPresented: Bool = false
    
    var body: some View {
        VStack {
            Button {
                isCalendarPresented = true
            } label: {
                HStack(spacing: 4) {
                    Text("selectedMonthYear")
                        .font(.headline)
                    
                    Image(systemName: "chevron.down")
                        .font(.system(size: 12, weight: .semibold))
                }
                .foregroundStyle(.primary)
            }
            .buttonStyle(.plain)
        }
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
