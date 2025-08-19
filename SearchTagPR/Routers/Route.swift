//
//  Route.swift
//  DailyReport
//
//  Created by 김민준 on 7/12/25.
//

import SwiftUI

/// URL 경로와 인자(선택)를 저장하는 라우트 모델
struct Route: Hashable {
    let name: String
    let arguments: AnyHashable?
}
