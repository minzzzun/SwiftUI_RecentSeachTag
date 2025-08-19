//
//  SearchViewModel.swift
//  SearchTagPR
//
//  Created by 김민준 on 8/19/25.
//

import Foundation

//MARK: - 검색 기록 관리
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var recentSeach: [String] = [] {
        didSet {
            saveRecent()
        }
    }
    
    init(){
        loadRecent()
    }
    
    //MARK: - 최근 검색 기록에 추가
    func pushRecentSearch(){
//        recentSeach.append(searchText)
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        recentSeach.removeAll { $0 == trimmed }
        recentSeach.insert(trimmed, at: 0)
        
        
        self.clear()
    }
    
    //MARK: - 검색어 삭제
    func popRecentSearch(text: String){
//        if let idx = recentSeach.firstIndex(of: text){
//            recentSeach.remove(at: idx)
//        }
        recentSeach.removeAll { $0 == text}
    }
    
    //MARK: - 최근 검색어 클릭
    func clickedRecent(text: String){
        self.searchText = text 
    }
    
    
    
    //MARK: - 전부 초기화
    func allClearRecentSearch(){
        self.recentSeach = []
    }

    // clear
    private func clear(){
        self.searchText = ""
    }
    
    // UserDefault에서 불러오기
    private func loadRecent(){
        if let data = UserDefaults.standard.data(forKey: "recent"),
           let array = try? JSONDecoder().decode([String].self, from: data){
            self.recentSeach = array
        }
            
    }
    
    // UserDefault로 저장
    private func saveRecent(){
        if let data  = try? JSONEncoder().encode(recentSeach){
            UserDefaults.standard.set(data, forKey: "recent")
        }
    }
    
}
