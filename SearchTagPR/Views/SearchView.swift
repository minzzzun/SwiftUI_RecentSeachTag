//
//  SearchView.swift
//  SearchTagPR
//
//  Created by 김민준 on 8/19/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = SearchViewModel()
    @EnvironmentObject var router: NavigationRouter
    @FocusState private var isSeachFocused: Bool
    
//    let gridItems = [
//        GridItem(.flexible(), alignment: .leading),
//        GridItem(.flexible(), alignment: .leading),
//        GridItem(.flexible(), alignment: .leading)
//    ]
    var body: some View {
        VStack {
            ///header
            HStack {
                Button(action: {
                    router.back()
                }) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                TextField("글 제목, 내용, 해시태그",text: $viewModel.searchText)
                    .padding(.horizontal, 3)
                    .padding(.vertical, 5)
                    .focused($isSeachFocused)
                    .background(.gray)
                    .cornerRadius(15)
                    .submitLabel(.search)
                    .onSubmit {
                        viewModel.pushRecentSearch()
                    }
                
            }
            .frame(height: 40)
//            .padding(.horizontal,15)
            .padding(.bottom, 12)
            
            /// 최근 검색어
            HStack {
                Text("최근 검색어")
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    viewModel.allClearRecentSearch()
                }) {
                    Text("전체 삭제")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
//            .padding(.horizontal,15)
            
//            LazyVGrid (columns: gridItems, spacing: 12){
//                ForEach(viewModel.recentSeach, id: \.self){ item in
//                    SeachTagView(seachText: item) {
//                        viewModel.popRecentSearch(text: item)
//                    }
//                }
//            }
            FlowLayout(spacing: 10, rowSpacing: 10) {
                ForEach(viewModel.recentSeach, id: \.self){ item in
                    SeachTagView(seachText: item) {
                        viewModel.popRecentSearch(text: item)
                    }
                    .onTapGesture {
                        viewModel.clickedRecent(text: item)
                        DispatchQueue.main.async {
                            isSeachFocused = true
                        }
                    }
                }
            }
//            .padding(.horizontal,15)

            
          
            
            Spacer()
        }
        .padding(.horizontal,15)
        .navigationBarHidden(true)
    }
}
