//
//  FavoriteRow.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

struct FavoriteRow: View {
    
    let favorite: Favorite
    
    var onFavoriteDoneAction: (() -> Void)?
    
    private var pureTextView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(self.favorite.name ?? "demo")
                    .font(.headline)
                Text(self.favorite.desc ?? "demo desc")
                    .font(.subheadline)
            }
            Spacer()
            HStack {
                Text("\(self.favorite.createTimeStr)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
    
    private var iconImageView: some View {
        Image("icon_test")
        .resizable()
        .frame(width: 80, height: 80, alignment: .center)
        .cornerRadius(4)
        .animation(.easeInOut)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if favorite.imageUrl != nil && favorite.imageUrl!.count > 0 {
                iconImageView
                pureTextView
            } else {
               pureTextView
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
        .contextMenu {
            ActionContextMenu(onAction: self.onFavoriteDoneAction)
        }
    }
}


struct FavoriteRow_Previews: PreviewProvider {
    static var previews: some View {
        
        return FavoriteRow(favorite: Favorite.simple())
    }
}
