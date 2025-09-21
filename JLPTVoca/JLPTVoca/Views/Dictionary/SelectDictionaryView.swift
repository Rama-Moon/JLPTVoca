//
//  SelectDictionaryView.swift
//  JLPTVoca
//
//  Created by Rama on 9/19/25.
//

import SwiftUI

enum SelectDictConstants {
    static let imageSize: CGFloat = 48
    static let imageLeadingPadding: CGFloat = 14
    static let imageTrailingPadding: CGFloat = 24
    static let imageVerticalPadding: CGFloat = 10
    
    static let iconWidth: CGFloat = 10
    static let iconHeight: CGFloat = 18
    static let iconTrailingPadding: CGFloat = 30
    
    static let buttonPadding: CGFloat = 16
    static let buttonRadius: CGFloat = 10
    
    static let tableVStackSpacing: CGFloat = 16
}

enum DictionaryType {
    case entire
    case favorite
    
    var title: String {
        switch self {
        case .entire:
            return "전체 단어"
        case .favorite:
            return "즐겨찾기 한 단어"
        }
    }
    
    var image: Image {
        switch self {
        case .entire:
            return Image(.wordCardRed)
        case .favorite:
            return Image(.wordCardBlue)
        }
    }
}

struct SelectDictionaryView: View {
    @State private var router = NavigationManager<DictionaryRoute>()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack(alignment: .topLeading) {
                Color.black5.ignoresSafeArea()
                
                Group {
                    VStack(alignment: .leading ,spacing: SelectDictConstants.tableVStackSpacing) {
                        dictionaryTypeButton(type: .entire)
                        dictionaryTypeButton(type: .favorite)
                    }
                }
                .padding(.horizontal, SelectDictConstants.buttonPadding)
            }
            .navigationDestination(for: DictionaryRoute.self) { route in
                switch route {
                case .entireWords:
                    DictionaryView(type: .entire)
                case .favoriteWords:
                    DictionaryView(type: .favorite)
                }
            }
        }
        .environment(router)
    }
    
    private func dictionaryTypeButton(type: DictionaryType) -> some View {
        return Button(action: {
            switch type {
            case .entire:
                router.navigate(.entireWords)
            case .favorite:
                router.navigate(.favoriteWords)
            }
        }) {
            HStack {
                type.image
                    .resizable()
                    .frame(width: SelectDictConstants.imageSize, height: SelectDictConstants.imageSize)
                    .padding(.leading, SelectDictConstants.imageLeadingPadding)
                    .padding(.trailing, SelectDictConstants.imageTrailingPadding)
                    .padding(.vertical, SelectDictConstants.imageVerticalPadding)
                
                Text(type.title)
                    .font(.b4)
                    .foregroundStyle(Color.black100)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(Color.black50)
                    .frame(width: SelectDictConstants.iconWidth, height: SelectDictConstants.iconHeight)
                    .padding(.trailing, SelectDictConstants.iconTrailingPadding)
            }
        }
        .background(Color.white0)
        .clipShape(RoundedRectangle(cornerRadius: SelectDictConstants.buttonRadius))
    }
}

#Preview {
    SelectDictionaryView()
}
