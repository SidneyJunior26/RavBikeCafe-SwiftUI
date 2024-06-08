import SwiftUI
import CoreData

struct ProdutosView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Produto.id, ascending: false)]
    ) var produtos: FetchedResults<Produto>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Total de Produtos: \(totalProdutos())")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                
                List {
                    ForEach(produtos) { produto in
                        NavigationLink(destination: Text("\(produto.id?.uuidString)")) {
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
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
    
    private func deleteProduto(offsets: IndexSet) {
        //
    }
    
    private func totalProdutos() -> Int {
        return produtos.count
    }
}

#Preview {
    ProdutosView()
}
