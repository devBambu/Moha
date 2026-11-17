//
//  PlanView.swift
//  Moha
//
//  Created by 변예린 on 8/21/26.
//

import Combine
import SwiftUI

struct PlanView: View {
    @Environment(\.locale) private var locale
    @Environment(\.calendar) private var calendar
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State var isCalendarPresented: Bool = false
    @State private var store = PlanStore()
    @State private var scrolledDate: Date?
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .padding(.trailing, 8)
                    .contentShape(Rectangle())
                    .background {
                        // 레이아웃 높이는 레이블 그대로 두고 터치 영역만 44pt로 확장해, 아래 날짜 제목과 간격 없이 겹치게 함
                        Color.clear
                            .frame(minHeight: 44)
                            .contentShape(Rectangle())
                    }
                }
                .buttonStyle(.plain)
                .popover(isPresented: $isCalendarPresented) {
                    PlanCalendarPopover(
                        selectedDate: store.state.selectedDate,
                        onSelect: { date in
                            store.send(.selectDate(date))
                            isCalendarPresented = false
                        },
                        onSelectToday: {
                            store.send(.selectToday)
                            isCalendarPresented = false
                        }
                    )
                    .presentationCompactAdaptation(.popover)
                }

                Spacer()
            }

            HStack {
                Text(PlanDateText.selectedDate(for: store.state.selectedDate, locale: locale))
                    .font(.title2)
                    .fontWeight(.bold)
                    .allowsHitTesting(false)

                Spacer()

                if !store.isSelectedDateToday {
                    Button {
                        store.send(.selectToday)
                    } label: {
                        Text("PlanView.today")
                            .frame(minWidth: 44)
                            .contentShape(Rectangle())
                            // 줄 높이를 늘리지 않도록 44pt 터치 영역은 레이아웃 밖으로 확장
                            .background {
                                Color.clear
                                    .frame(minHeight: 44)
                                    .contentShape(Rectangle())
                            }
                    }
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                }

                Button {
                    //TODO: 계획 표시 설정 동작
                    print("plan setting")
                } label: {
                    Image(systemName: "gearshape")
                        // 줄 높이를 늘리지 않도록 44pt 터치 영역은 레이아웃 밖으로 확장
                        .background {
                            Color.clear
                                .frame(minWidth: 44, minHeight: 44)
                                .contentShape(Rectangle())
                        }
                }
                .foregroundStyle(.primary)
            }
        }
        .padding(.horizontal, 16)

        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(store.visibleDates, id: \.self) { date in
                    let isSelected = date == store.state.selectedDate
                    let isToday = date == store.state.today

                    Button {
                        store.send(.selectDate(date))
                    } label: {
                        VStack(spacing: 4) {
                            Text(PlanDateText.weekday(for: date, locale: locale))
                                .font(.caption2)
                                .fontWeight(.regular)
                                .foregroundStyle(isSelected ? .white : .secondary)
                            
                            Text(date, format: .dateTime.locale(locale).day())
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundStyle(isSelected ? .white : .primary)
                                .frame(height: 18)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 66)
                        .contentShape(Rectangle()) // 터치 영역 설정 - background의 padding 2포인트까지 터치 영역으로 포함
                    }
                    .buttonStyle(.plain)
                    .accessibilityValue(isToday ? Text("PlanView.today") : Text(verbatim: "")) // 접근성 VoiceOver
                    .accessibilityAddTraits(isSelected ? .isSelected : []) // 접근성 VoiceOver
                    .containerRelativeFrame(.horizontal, count: 7, span: 1, spacing: 0) // 날짜 한 칸의 너비를 스크롤뷰의 1/7로 설정
                    .background {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 12)
                                .fill(.blue)
                                .padding(.horizontal, 2)
                        } else if isToday {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(.blue, lineWidth: 1)
                                .padding(.horizontal, 2)
                        }
                    }
                }
            }
            .scrollTargetLayout() // LazyHStack의 각 날짜 칸을 스크롤 정렬 대상으로 등록 - scrollTargetLayout()은 해당 레이아웃의 직접 자식 뷰들을 스크롤 대상으로 취급
        }
        .scrollIndicators(.hidden)
        .scrollPosition(id: $scrolledDate, anchor: .center)
        .scrollTargetBehavior(.viewAligned) // 손을 떼어 스크롤이 멈출 때, scrollTargetLayout에서 등록한 날짜 칸 경계에 맞춰 멈춤. 기본 정렬은 앞쪽 가장자리를 기준으로 함.
        .padding(.horizontal, 16)
        .onAppear {
            scrolledDate = store.state.selectedDate
        }
        .onChange(of: store.state.selectedDate) { _, selectedDate in
            if reduceMotion {
                scrolledDate = selectedDate
            } else {
                withAnimation {
                    scrolledDate = selectedDate
                }
            }
        }
        .onChange(of: scenePhase) { _, phase in
            if phase == .active {
                store.send(.appBecameActive(now: .now, calendar: calendar))
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .NSCalendarDayChanged).receive(on: DispatchQueue.main)) { _ in
            if scenePhase == .active {
                store.send(.appBecameActive(now: .now, calendar: calendar))
            }
        }
    }
}

//MARK: - PlanView Preview
#Preview {
    PlanView()
}
