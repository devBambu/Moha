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
        VStack(spacing: 4) {
            HStack {
                Button {
                    isCalendarPresented = true
                } label: {
                    HStack(spacing: 4) {
                        Text("selectedMonthYear")
                            .font(.headline)
                            .fontWeight(.medium)
                        
                        Image(systemName: "chevron.down")
                            .font(.headline)
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
            
            HStack {
                Text("PlanView.Weekday.title")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
