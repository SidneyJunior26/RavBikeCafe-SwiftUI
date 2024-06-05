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
    
    @State private var descricao = ""
    @State private var valor: Double = 0
    
    var body: some View {
        Form {
            Section {
                TextField("Descrição Produto", text: $descricao)
                
                TextField("Valor", value: $valor, format: .currency(code: "BRL"))
                    .keyboardType(.numberPad)
                
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
