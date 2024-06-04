//
//  ContentView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dimiss
    
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    let menuItems = [
        MenuItem(name: "Comandas", icon: "list.bullet"),
        MenuItem(name: "Produtos", icon: "cart"),
        MenuItem(name: "Estoque", icon: "archivebox"),
        MenuItem(name: "Consultas", icon: "magnifyingglass")
    ]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
            NavigationView {
                VStack(alignment: .center) {
                    ScrollView {
                        Image("Logo")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 200, height: 200)
                            .clipped()
                            .clipShape(Circle())
                            .shadow(color: .gray, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(10)
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(menuItems) { item in
                                NavigationLink(destination: destinationView(for: item.name)) {
                                                                MenuItemView(item: item, isDarkMode: isDarkMode)
                                                            }
                            }
                        }
                        .padding()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Ravelli Bike Café")
                            .foregroundColor(isDarkMode ? .white : .black)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isDarkMode.toggle() // Troca o estado do tema
                        }) {
                            Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                                .foregroundColor(isDarkMode ? .white : .black)
                        }
                    }
                }
                .padding()
                .background(isDarkMode ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all))
            }
            .colorScheme(isDarkMode ? .dark : .light)
        }
    
    @ViewBuilder
    private func destinationView(for name: String) -> some View {
        switch name {
        case "Comandas":
            ComandasView()
        case "Produtos":
            ProdutosView()
        default:
            Text("\(name) View")
                .foregroundColor(isDarkMode ? .white : .black)
        }
    }
}

struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var icon: String
}

struct MenuItemView: View {
    let item: MenuItem
    let isDarkMode: Bool
    
    var body: some View {
        VStack {
            Image(systemName: item.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding()
                .background(Color.orange.opacity(0.1))
                .cornerRadius(10)
                .foregroundColor(.orange)
            Text(item.name)
                .font(.headline)
                .foregroundColor(isDarkMode ? .white : .black)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
