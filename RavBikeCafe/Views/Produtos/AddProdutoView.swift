//
//  AddProdutoView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 02/06/24.
//

import SwiftUI
import CoreData

struct AddProdutoView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss   
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \CategoriaProduto.id, ascending: false)]
    ) var categoriasProduto: FetchedResults<CategoriaProduto>
    
    @State private var descricao = ""
    @State private var valor: Double = 0
    @State private var idCategoria: UUID? = nil
    
    @State private var searchQuery = ""
    
    @State private var selected = false
    @State private var categoriaSelecionada: CategoriaProduto?
    
    var body: some View {
        Form {
            Section {
                TextField("Descrição Produto", text: $descricao)
                
                TextField("Valor", value: $valor, format: .currency(code: "BRL"))
                    .keyboardType(.numberPad)
                    .padding()
                                
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Text("Selecione uma Categoria")
                            .font(.title2)
                            .bold()
                        Spacer()
                    }
                    
                    TextField("Pesquisar", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                    
                    List(selection: $categoriaSelecionada) {
                        ForEach(categoriasProduto.filter { categoria in
                            searchQuery.isEmpty ||
                            categoria.descricao?.contains(searchQuery) == true
                        }) { categoria in
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(categoria.descricao ?? "Sem descrição")
                                        .bold()
                                }
//                                Spacer()
//                                Toggle(isOn: $selected) {
//                                    
//                                }
//                                .onChange(of: selected) {
//                                    if selected {
//                                        idCategoria = categoria.id!
//                                    }
//                                    else {
//                                        idCategoria = nil
//                                    }
//                                }
//                                .disabled(selected)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(minHeight: 200)
                }
                
                HStack {
                    Spacer()
                    Button("Salvar") {
                        DataController().addProduto(descricao: descricao, valor: valor, context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
}

#Preview {
    AddProdutoView()
}
