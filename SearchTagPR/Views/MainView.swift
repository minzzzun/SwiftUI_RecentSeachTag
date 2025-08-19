//
//  MainView.swift
//  SearchTagPR
//
//  Created by 김민준 on 8/19/25.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        HStack{
            Image(systemName: "globe.europe.africa")
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            Spacer()
            
            Button(action:{
                router.toNamed("/search")
            }){
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
        }
        .foregroundColor(.gray)
        .frame(height: 40)
        .padding(.horizontal, 15)
        .padding(.bottom, 30)
        
        Text("메인 게시판")
        
        
        Spacer()
    }
}

