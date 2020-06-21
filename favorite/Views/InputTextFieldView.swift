//
//  InputTextFieldView.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/21.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

struct InputTextFieldView: View {
    
    let label: String
    let placeholder: String
    
    @Binding var inputText: String
    
    var body: some View {
        VStack {
            HStack {
                Text(self.label)
                TextField(self.placeholder, text: $inputText)
            }.frame(height: 44, alignment: .leading)
        }
    }
}

struct InputTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        InputTextFieldView(label: "Name",
                           placeholder: "Your Favorite Name",
                           inputText: Binding<String>.init(get: { () -> String in
            return "demo"
        }, set: { text in
            
        }))
    }
}
