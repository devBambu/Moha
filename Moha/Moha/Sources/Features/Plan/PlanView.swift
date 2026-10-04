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
                    .containerRelativeFrame(.horizontal, count: 7, span: 1, spacing: 0) // 날짜 한 칸의 너비를 스크롤뷰의 1/7로 설정
                }
            }
            .scrollTargetLayout() // LazyHStack의 각 날짜 칸을 스크롤 정렬 대상으로 등록 - scrollTargetLayout()은 해당 레이아웃의 직접 자식 뷰들을 스크롤 대상으로 취급
        }
        .scrollIndicators(.hidden)
        .defaultScrollAnchor(.center)
        .scrollTargetBehavior(.viewAligned) // 손을 떼어 스크롤이 멈출 때, scrollTargetLayout에서 등록한 날짜 칸 경계에 맞춰 멈춤. 기본 정렬은 앞쪽 가장자리를 기준으로 함.
        .padding(.horizontal, 16)
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
