//
//  PlanView.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import SwiftUI

struct PlanView: View {
    @Environment(\.locale) private var locale
    @State var isCalendarPresented: Bool = false
    @State private var store = PlanStore()
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Button {
                    isCalendarPresented = true
                } label: {
                    HStack(spacing: 4) {
                        Text(PlanDateText.yearMonth(for: store.state.selectedDate, locale: locale))
                            .font(.footnote)
                            .fontWeight(.medium)
                        
                        Image(systemName: "chevron.down")
                            .font(.footnote)
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
                Text(PlanDateText.selectedDate(for: store.state.selectedDate, locale: locale))
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(store.visibleDates, id: \.self) { date in
                    let isSelected = date == store.state.selectedDate

                    Button {
                        store.send(.selectDate(date))
                    } label: {
                        VStack(spacing: 2) {
                            Text(PlanDateText.weekday(for: date, locale: locale))
                                .font(.caption2)
                                .fontWeight(.regular)
                                .foregroundStyle(.secondary)

                            Text(date, format: .dateTime.locale(locale).day())
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(isSelected ? .white : .primary)
                                .frame(width: 40, height: 40)
                        }
                    }
                    .buttonStyle(.plain)
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
