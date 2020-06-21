//
//  BorderedButton.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

public struct BorderedButton: View {
    public let text: String
    public let imageName: String
    public let color: Color
    public let isOn: Bool
    public let action: () -> Void
    
    public init(text: String, imageName: String, color: Color, isOn: Bool, action: @escaping () -> Void) {
        self.text = text
        self.imageName = imageName
        self.color = color
        self.isOn = isOn
        self.action = action
    }
    
    public var body: some View {
        Button(action: {
            self.action()
        }, label: {
            HStack(alignment: .center, spacing: 4) {
                Image(systemName: imageName)
                    .foregroundColor(isOn ? .white : color)
                Text(text)
                    .foregroundColor(isOn ? .white : color)
            }
            })
        .buttonStyle(BorderlessButtonStyle())
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color, lineWidth: isOn ? 0 : 2)
                .background(isOn ? color : .clear)
                .cornerRadius(8)
        )
    }
}

struct BorderedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            BorderedButton(text: "Add to wishlist",
                           imageName: "film",
                           color: .green,
                           isOn: false,
                           action: {
                            
            })
            BorderedButton(text: "Add to wishlist",
                           imageName: "film",
                           color: .blue,
                           isOn: true,
                           action: {
                            
            })
        }
    }
}
