//
//  ContentView.swift
//  Search Bar with Filter
//
//  Created by Admin on 9/6/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var searchText = ""
    @State var isSearching = false
    let layout = [GridItem(.adaptive(minimum: 100))]    //[GridItem(.fixed(20))]
    @State var movies = [

        Model(id: 0, name: "Rampage", actor: "The Rock", photo: "p0"),
        Model(id: 1, name: "21 Street", actor: "Jonna Hill", photo: "p1"),
        Model(id: 2, name: "Avatar 2", actor: "Sam Worthington", photo: "p2"),
        Model(id: 3, name: "Skyscraper", actor: "The Rock", photo: "p3"),
        Model(id: 4, name: "Titanic", actor: "Leonardo Di Caprio", photo: "p4"),
        Model(id: 5, name: "King Kong", actor: "Naomi Watts", photo: "p5"),
        Model(id: 6, name: "Underworld", actor: "Kate Beckinsale", photo: "p6"),
        Model(id: 7, name: "R.I.P.D", actor: "Ryan Reynolds", photo: "p7"),
        Model(id: 8, name: "Heist", actor: "Adrien Browdy", photo: "p8"),
        Model(id: 9, name: "Hunter Killer", actor: "Gerrard Batler", photo: "p9"),
        Model(id: 10, name: "211", actor: "Nickolas Cage", photo: "p10"),
        Model(id: 11, name: "JQ Cobra", actor: "Bruce Willias", photo: "p11")
    
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                
                SearchBar(searchText: $searchText, isSearching: $isSearching)
                    .padding(.top, 15)
                
                LazyVGrid(columns: layout, spacing: 30) {
                    ForEach((movies).filter({ "\($0)".contains(searchText) || searchText.isEmpty }), id: \.self) { i in
                        VStack(alignment: .leading, spacing: 27) {
                            Image("\(i.photo)")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                          
                            Text("\(i.name)")
                                .font(.system(size: 15))
                                .fontWeight(.semibold)
                        }
                        .padding()
                    }
                }
                .padding(.horizontal)
                .padding(.top, 25)
            }
            .navigationTitle("Menu")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
    }
}

struct SearchBar: View {
    
    @Binding var searchText: String
    @Binding var isSearching: Bool
    
    var body: some View {
        HStack {
            HStack {
                TextField("Search terms here", text: $searchText)
                    .padding(.leading, 25)
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(12)
            .padding(.horizontal)
            .onTapGesture {
                isSearching = true
            }
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                    Spacer()
                    
                    if isSearching {
                        Button(action: { searchText = "" }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .padding(.vertical)
                        })
                    }
                }
                .padding(.horizontal, 32)
                .foregroundColor(.gray)
            )
            .transition(.move(edge: .trailing))
            .animation(.spring())
            
            if isSearching {
                Button(action: {
                    isSearching = false
                    searchText = ""
                    
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    
                }, label: {
                    Text("Cancel")
                        .padding(.trailing)
                        .padding(.leading, -12)
                })
                .transition(.move(edge: .trailing))
                .animation(.spring())
            }
        }
    }
}

struct Model: Hashable {
    var id: Int
    var name: String
    var actor: String
    var photo: String
}
