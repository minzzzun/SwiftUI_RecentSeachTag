//
//  SeachTagView.swift
//  SearchTagPR
//
//  Created by 김민준 on 8/19/25.
//

import SwiftUI

struct SeachTagView: View {
    let seachText: String
    let action : () -> Void
    
    var body: some View {
        HStack {
            Text(seachText)
                .font(.caption)
                .foregroundColor(.white)
            Spacer()
            
            Button(action: action){
                Text("X")
                    .foregroundColor(.white)
                    .font(.caption)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .overlay {
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.gray, lineWidth: 2)
        }
    }
}

