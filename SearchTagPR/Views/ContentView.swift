//
//  ContentView.swift
//  SearchTagPR
//
//  Created by 김민준 on 8/19/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            MainView()
                .navigationDestination(for: Route.self) { route in
                    switch route.name {
                    case "/":
                        MainView()
                    case "/main":
                        MainView()
                    case "/search":
                        SearchView()
                    default:
                        Text("알 수 없는 경로")
                    }
                }
            
        }
        .environmentObject(router)
        
        
    }
}

