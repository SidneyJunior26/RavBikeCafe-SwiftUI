//
//  RavBikeCafeApp.swift
//  RavBikeCafe
//
//  Created by Sidney Junior on 30/05/24.
//

import SwiftUI

@main
struct RavBikeCafeApp: App {
    let dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
