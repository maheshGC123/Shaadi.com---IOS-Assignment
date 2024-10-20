//
//  ShaadiIOSAssignmentApp.swift
//  ShaadiIOSAssignment
//
//  Created by Mahesh G C on 18/10/24.
//

import SwiftUI

@main
struct ShaadiIOSAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
