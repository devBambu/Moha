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
            HStack {
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
                
                Spacer()
                
                Button {
                    //TODO: 계획 표시 설정 동작
                    print("plan setting")
                } label: {
                    Image(systemName: "gearshape")
                        
                }
                .foregroundStyle(.primary)
            }
        }
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
