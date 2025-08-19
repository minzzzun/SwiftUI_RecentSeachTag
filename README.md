# 최신 검색어 목록 태그 기능

### 1. 이렇게 검색어 길이에 따라 태그 조절 
<img src="https://github.com/user-attachments/assets/34a49a36-17b4-43a7-a7ce-60b620f86d06" width="300" height="600">

> 아래의 코드를 파일에 추가해서 사용 
```swift
import Foundation
import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8  // 같은 줄에서 아이템들 사이의 가로 간격
    var rowSpacing: CGFloat = 8 // 줄과 줄 사이의 세로 간격

    // 측정
    func sizeThatFits(proposal: ProposedViewSize,
                      subviews: Subviews,
                      cache: inout ()) -> CGSize {
        let maxWidth = proposal.width ?? .infinity
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for s in subviews {
            let size = s.sizeThatFits(.unspecified)
            if x + size.width > maxWidth {
                // 줄바꿈
                x = 0
                y += rowHeight + rowSpacing
                rowHeight = 0
            }
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }
        return CGSize(width: maxWidth, height: y + rowHeight)
    }

    // 배치 
    func placeSubviews(in bounds: CGRect,
                       proposal: ProposedViewSize,
                       subviews: Subviews,
                       cache: inout ()) {
        var x = bounds.minX
        var y = bounds.minY
        var rowHeight: CGFloat = 0

        for s in subviews {
            let size = s.sizeThatFits(.unspecified)
            if x + size.width > bounds.maxX {
                // 줄바꿈
                x = bounds.minX
                y += rowHeight + rowSpacing
                rowHeight = 0
            }
            s.place(at: CGPoint(x: x, y: y),
                    proposal: ProposedViewSize(width: size.width, height: size.height))
            x += size.width + spacing
            rowHeight = max(rowHeight, size.height)
        }
    }
}
```

> 이렇게 사용 
```swift
    FlowLayout(spacing: 10, rowSpacing: 10) {
        ForEach(viewModel.recentSeach, id: \.self){ item in
            // 여기 CellView 추가 
            SeachTagView(seachText: item) {
                viewModel.popRecentSearch(text: item)
            }
            .onTapGesture {  // 셀뷰 클릭시 기능 
                viewModel.clickedRecent(text: item)
                DispatchQueue.main.async {
                    isSeachFocused = true
                }
            }
        }
    }


```

### 2. 검색어 ViewModel 
- 여기에서 검색 네트워크 API Manager 기능 추가해서 사용하면 됨

```swift
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
        let trimmed = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        recentSeach.removeAll { $0 == trimmed }
        recentSeach.insert(trimmed, at: 0)
        self.clear()
    }
    
    //MARK: - 검색어 삭제
    func popRecentSearch(text: String){
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
```

---
https://github.com/user-attachments/assets/1a49ad66-8bbf-4160-9fbe-4022dcb4b97c

