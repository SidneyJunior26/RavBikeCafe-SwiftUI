//
//  CategoriasView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 08/06/24.
//

import SwiftUI
import CoreData

struct CategoriasView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Produto.id, ascending: false)]
    ) var categorias: FetchedResults<CategoriaProduto>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(categorias) {
                        categoria in
                        NavigationLink(destination: Text("\(categoria.id?.uuidString)")) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(categoria.description)
                                        .bold()
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteCategoria)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Categoria de Produtos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Text("Add Categoria")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
    
    private func deleteCategoria(offsets: IndexSet) {
        //
    }
        
}

#Preview {
    CategoriasView()
}
