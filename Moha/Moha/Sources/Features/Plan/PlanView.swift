//
//  PlanView.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct PlanView: View {
    @State var isCalendarPresented: Bool = false
    
    let weekdays = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT",
                    "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT",
                    "SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let days = ["19", "20", "21", "22", "23", "24", "25",
                "26", "27", "28", "29", "30", "31", "1",
                "2", "3", "4", "5", "6", "7", "8"]
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Button {
                    isCalendarPresented = true
                } label: {
                    HStack(spacing: 4) {
                        Text("PlanView.yearMonthSelection")
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

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(days.indices, id: \.self) { index in
                    let isSelected = days[index] == "28"

                    VStack(spacing: 2) {
                        Text(weekdays[index])
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)

                        Text(days[index])
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(isSelected ? .white : .primary)
                            .frame(width: 40, height: 40)
                    }
                    .frame(width: 40)
                    .background {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blue)
                            }
                    }
                    .containerRelativeFrame(.horizontal, count: 7, span: 1, spacing: 0)
                }
            }
            .scrollTargetLayout()
        }
        .scrollIndicators(.hidden)
        .defaultScrollAnchor(.center)
        .scrollTargetBehavior(.viewAligned)
        .padding(.horizontal, 16)
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
