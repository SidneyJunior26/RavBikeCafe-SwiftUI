import SwiftUI
import CoreData

struct ProdutosView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Produto.id, ascending: false)]
    ) var produtos: FetchedResults<Produto>
    
    @State private var showingAddView = false
    
    @AppStorage("isDarkMode") private var isDarkMode = true
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Total de Produtos: \(totalProdutos())")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(produtos) { produto in
                        NavigationLink(destination: Text("\(produto.id?.uuidString ?? "Desconhecido")")) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(produto.descricao ?? "Sem descrição")
                                        .bold()
                                    
                                    Text("R$ \(produto.valor, specifier: "%.2f")")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteProduto)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Produtos")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Text("Add Produto")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddProdutoView()
                    .environment(\.managedObjectContext, managedObjContext)
            }
        }
    }
    
    private func deleteProduto(offsets: IndexSet) {
        withAnimation {
            offsets.map { produtos[$0] }.forEach(managedObjContext.delete)
            do {
                try managedObjContext.save()
            } catch {
                print("Erro ao deletar produto: \(error.localizedDescription)")
            }
        }
    }
    
    private func totalProdutos() -> Int {
        return produtos.count
    }
}

#Preview {
    ProdutosView()
}
