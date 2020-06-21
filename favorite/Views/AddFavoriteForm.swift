//
//  AddFavoriteForm.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/4.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

struct AddFavoriteForm: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var favoriteStore: FavoriteStore
    
    @State private var favName = ""
    @State private var favDesc = ""
    @State private var favIcon = ""
    
    @Binding var favList: [Favorite]
    
    private var nameSection: some View {
        return Section(header: Text("New Favorite")) {
            VStack {
                InputTextFieldView(label: "Icon",
                                   placeholder: "Name your icon",
                                   inputText: $favIcon)
                InputTextFieldView(label: "Name",
                                   placeholder: "Name your favorite",
                                   inputText: $favName)
                InputTextFieldView(label: "Description",
                                   placeholder: "Describe your favorite",
                                   inputText: $favDesc)
            }
        }
    }
    
    private var doneButton: some View {
        Button(action: {
            let fav = self.favoriteStore.create(
                name: self.favName,
                desc: self.favDesc,
                icon: self.favIcon
            )
            self.favList.insert(fav, at: 0)
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Done")
        }
    }
    
    private var cancelButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Text("Cancel")
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                nameSection
            }
            .navigationBarTitle(Text("New Favorite"))
            .navigationBarItems(leading: cancelButton, trailing: doneButton)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddFavoriteForm_Previews: PreviewProvider {
    static var previews: some View {
        AddFavoriteForm(favList: Binding<[Favorite]>.init(get: { () -> [Favorite] in
            []
        }, set: { fav in
            
        }))
    }
}
