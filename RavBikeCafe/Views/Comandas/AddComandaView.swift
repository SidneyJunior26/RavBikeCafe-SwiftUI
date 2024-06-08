//
//  AddComandaView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 01/06/24.
//

import SwiftUI
import CoreData

struct AddComandaView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Comandas.id, ascending: false)]
        ) var itens: FetchedResults<ItemComanda>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Produto.id, ascending: false)]
    ) var produtos: FetchedResults<Produto>
    
    @State private var nomeCliente = ""
    @State private var pago = false
    @State private var searchQuery = ""
    @State private var quantidade = [UUID: Int]()
    
    var body: some View {
        Form {
            Section {
                TextField("Nome Cliente", text: $nomeCliente)
                
                Toggle(isOn: $pago) {
                    Text("Pago")
                }
                
                VStack(alignment: .leading) {
                    Text("Produtos")
                        .font(.title2)
                        .bold()
                    
                    TextField("Pesquisar por ID ou Descrição", text: $searchQuery)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.bottom)
                    
                    List {
                        ForEach(produtos.filter { produto in
                            searchQuery.isEmpty ||
                            produto.descricao?.contains(searchQuery) == true ||
                            produto.id?.uuidString.contains(searchQuery) == true
                        }) { produto in
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(produto.descricao ?? "Sem descrição")
                                        .bold()
                                    Text("R$ \(produto.valor, specifier: "%.2f")")
                                        .foregroundColor(.blue)
                                }
                                Spacer()
                                HStack {
                                    Button(action: {
                                        diminuirQuantidade(produto: produto)
                                    }) {
                                        Image(systemName: "minus")
                                            .foregroundColor(.red)
                                    }
                                    Text("\(quantidade[produto.id ?? UUID()] ?? 0)")
                                        .padding(.horizontal, 8)
                                    Button(action: {
                                        aumentarQuantidade(produto: produto)
                                    }) {
                                        Image(systemName: "plus")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(minHeight: 50)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    
                    Text("Itens")
                        .font(.title2)
                        .bold()
                        
                    List {
                        ForEach(itens) { item in
                            NavigationLink(destination: Text("\(item.idComanda!)")) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text("\(item.idProduto!) - \(item.quantidade)")
                                            .bold()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .listStyle(.plain)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button("Salvar") {
                        
                    }
                    Spacer()
                }
            }
        }
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
    
    private func deleteItem(offsets: IndexSet) {
        //
    }
    
    private func diminuirQuantidade(produto: Produto) {
        guard let id = produto.id else { return }
        if let currentQuantity = quantidade[id], currentQuantity > 0 {
            quantidade[id] = currentQuantity - 1
        }
    }
    
    private func aumentarQuantidade(produto: Produto) {
        guard let id = produto.id else { return }
        quantidade[id, default: 0] += 1
    }
    
    private func adicionarItemComanda(produto: Produto) {
        let novoItem = ItemComanda(context: managedObjContext)
        novoItem.idProduto = produto.id
        novoItem.idComanda = UUID() // Substitua pelo ID da comanda correta
        novoItem.quantidade = 1 // Defina a quantidade inicial
        
        do {
            try managedObjContext.save()
        } catch {
            print("Erro ao adicionar item à comanda: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddComandaView()
}
