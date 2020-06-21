//
//  ContentView.swift
//  favorite
//
//  Created by 谷雷雷 on 2020/6/3.
//  Copyright © 2020 acumen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var store: FavoriteStore
    
    enum FavoriteFilter: Int {
        case want
        case done
        
        var label: String {
            switch self {
            case .want: return "Want to do"
            case .done: return "Done"
            }
        }
    }
    
    @State private var isAddFormPresented = false
    @State private var selectedFilter: FavoriteFilter = .want
    @State private var isUpdated: Bool = false
    @State private var undoneList = [Favorite]()
    @State private var doneList = [Favorite]()
    
    private var addBarItem: some View {
        Button(action: {
            self.isAddFormPresented = true
        }) {
            Text("Add")
        }
    }
    
    private var undoneListView: some View {
        Section {
            ForEach(self.undoneList, id: \.self) { item in
                FavoriteRow(favorite: item, onFavoriteDoneAction: {
                    self.store.done(favorite: item)
                    self.undoneList.removeAll { item == $0 }
                    self.doneList.insert(item, at: 0)
                })
            }.onDelete { set in
                if let index = set.first {
                    let item = self.store.undoneList[index]
                    self.undoneList.remove(at:index)
                    self.store.delete(item)
                }
            }
        }
    }
    
    private var doneListView: some View {
        Section {
            ForEach(self.doneList, id: \.self) { item in
                FavoriteRow(favorite: item)
            }.onDelete { set in
                if let index = set.first {
                    let item = self.store.doneList[index]
                    self.doneList.remove(at:index)
                    self.store.delete(item)
                }
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Lists", selection: $selectedFilter) {
                        ForEach([FavoriteFilter.want, FavoriteFilter.done], id: \.self) {
                            Text($0.label).tag($0.rawValue)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
              
                if selectedFilter == FavoriteFilter.want {
                    undoneListView
                } else if selectedFilter == FavoriteFilter.done {
                    doneListView
                }
            }
            .navigationBarTitle("Favorite")
            .navigationBarItems(trailing: addBarItem)
        }
        .sheet(isPresented: $isAddFormPresented) {
            AddFavoriteForm(favList: self.$undoneList).environmentObject(self.store)
        }.onAppear {
            self.doneList = self.store.doneList
            self.undoneList = self.store.undoneList
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(FavoriteStore())
    }
}
