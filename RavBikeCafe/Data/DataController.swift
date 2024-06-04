//
//  DataController.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 31/05/24.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "RavBikeCafeModel")
    
    init () {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addComanda(nomeCliente: String, pago: Bool, context: NSManagedObjectContext) {
        let comanda = Comandas(context: context)
        
        comanda.id = UUID()
        comanda.data = Date()
        comanda.nomeCliente = nomeCliente
        comanda.pago = pago
        
        save(context: context)
    }
    
    func editComanda(comanda: Comandas, nomeCliente: String, pago: Bool, context: NSManagedObjectContext) {
        comanda.nomeCliente = nomeCliente
        comanda.pago = pago
        
        save(context: context)
    }
    
    func addItemComanda(idComanda: UUID, idProduto: UUID, quantidade: Int16, valor: Double, context: NSManagedObjectContext) {
        let itemComanda = ItemComanda(context: context)
        
        itemComanda.id = UUID()
        itemComanda.idComanda = idComanda
        itemComanda.idProduto = idProduto
        itemComanda.quantidade = quantidade
        itemComanda.valor = valor
        
        save(context: context)
    }
    
    func editItemComanda(idProduto: UUID, quantidade: Int16, valor: Double, itemComanda: ItemComanda, context: NSManagedObjectContext) {
        itemComanda.idProduto = idProduto
        itemComanda.quantidade = quantidade
        itemComanda.valor = valor
        
        save(context: context)
    }
    
    func addProduto(descricao: String, valor: Double, context: NSManagedObjectContext) {
        let produto = Produto(context: context)
        
        produto.id = UUID()
        produto.descricao = descricao
        produto.valor = valor
        
        save(context: context)
    }
    
    func editProduto(produto: Produto, descricao: String, valor: Double, categoriaId: UUID, context: NSManagedObjectContext) {
        produto.descricao = descricao
        produto.valor = valor
        produto.categoriaId = categoriaId
        
        save(context: context)
    }
    
    func addCategoriaProduto(descricao: String, context: NSManagedObjectContext) {
        let categoria = CategoriaProduto(context: context)
        
        categoria.id = UUID()
        categoria.descricao = descricao
        
        save(context: context)
    }
    
    func editCategoriaProduto(categoria: CategoriaProduto, descricao: String, context: NSManagedObjectContext) {
        categoria.descricao = descricao;
        
        save(context: context)
    }
}
