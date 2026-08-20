//
//  Route.swift
//  Moha
//
//  Created by 변예린 on 8/20/26.
//

protocol Route: Hashable {
    var id: String { get } // NavigationPath에서 사용되는 키값
}

// extension으로 Hashable 프로토콜의 필수 구현사항을 구현함으로써 중복 코드 최소화
extension Route {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
