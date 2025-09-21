//
//  FavoriteButton.swift
//  JLPTVoca
//
//  Created by Rama on 9/20/25.
//

import SwiftUI

enum FavoriteButtonConstant {
    static let ImageSize: CGFloat = 30
}

struct FavoriteButton: View {
    let isFavorited: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(isFavorited ? .favoriteIconActivated : .favoriteIconInactivated)
                .resizable()
                .frame(width: FavoriteButtonConstant.ImageSize, height: FavoriteButtonConstant.ImageSize)
        }
    }
}
