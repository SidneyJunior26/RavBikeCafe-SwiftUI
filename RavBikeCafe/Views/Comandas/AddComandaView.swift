//
//  AddComandaView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 01/06/24.
//

import SwiftUI

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
    
    var body: some View {
        Form {
            Section {
                TextField("Nome Cliente", text: $nomeCliente)
                
                Toggle(isOn: $pago) {
                    Text("Pago")
                }
                
                VStack(alignment: .leading) {
                    Text("Adicionar Produto")
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
                            NavigationLink(destination: Text("\(produto.id?.uuidString ?? "Desconhecido")")) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 6) {
                                        Text(produto.descricao ?? "Sem descrição")
                                            .bold()
                                        Text("R$ \(produto.valor, specifier: "%.2f")")
                                            .foregroundColor(.blue)
                                    }
                                    Spacer()
                                    Button(action: {
                                        adicionarItemComanda(produto: produto)
                                    }) {
                                        Image(systemName: "plus.circle")
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                    .frame(minHeight: 100)
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
    }
    
    private func deleteItem(offsets: IndexSet) {
        //
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
