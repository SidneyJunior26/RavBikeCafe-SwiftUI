//
//  AddCategoriaView.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 08/06/24.
//

import SwiftUI
import CoreData

struct AddCategoriaView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @State private var descricao = ""
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading) {
                Form {
                    Section {
                        TextField("Descrição", text: $descricao)
                    }
                }
            }
            .navigationTitle("Nova Categoria")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        DataController().addCategoriaProduto(descricao: descricao, context: managedObjContext)
                        dismiss()
                    } label: {
                        Text("Salvar")
                    }
                }
            }
        }
        .colorScheme(ContentView().isDarkMode ? .dark : .light)
    }
}

#Preview {
    AddCategoriaView()
}
