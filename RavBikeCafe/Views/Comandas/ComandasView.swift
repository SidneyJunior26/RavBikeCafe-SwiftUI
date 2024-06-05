//
//  ComandasView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 31/05/24.
//

import SwiftUI
import CoreData

struct ComandasView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Comandas.data, ascending: false)],
            predicate: NSPredicate(format: "data >= %@", Calendar.current.startOfDay(for: Date()) as NSDate)
        ) var comandas: FetchedResults<Comandas>
    
    @State private var showingAddView = false
    
    var body: some View {        
        NavigationView {
            VStack(alignment: .leading) {
                Text("R$\(totalHoje(), specifier: "%.2f") Total (Hoje)")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(comandas) { comanda in
                        NavigationLink(destination: Text("\(comanda.id)")) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\(comanda.numero) - \(comanda.nomeCliente!)")
                                        .bold()
                                    
                                    Text(comanda.pago ? "Pago" : "Não Pago")
                                        .foregroundColor(comanda.pago ? .green : .red)
                                }
                                Spacer()
                                
                            }
                        }
                    }
                    .onDelete(perform: deleteComanda)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Comandas")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Text("Nova Comanda")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddComandaView()
            }
        }
        .navigationViewStyle(.stack)
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
    
    private func deleteComanda(offsets: IndexSet) {
        //
    }
    
    private func totalHoje() -> Double {
        return 10.0
    }
}

#Preview {
    ComandasView()
}
