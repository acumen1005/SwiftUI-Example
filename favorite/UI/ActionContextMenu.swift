//
//  ActionContextMenu.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

struct ActionContextMenu: View {
    
    var onAction: (() -> Void)?
    
    var body: some View {
        VStack {
            Button(action: {
                self.onAction?()
            }) {
                HStack {
                    Text("Done")
                    Image(systemName: "heart")
                        .imageScale(.small)
                        .foregroundColor(.primary)
                }
            }
        }
    }
}

struct ActionContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ActionContextMenu()
    }
}
