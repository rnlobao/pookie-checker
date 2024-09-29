//
//  pookie_checkerApp.swift
//  pookie-checker
//
//  Created by Robson Novato on 12/08/24.
//

import SwiftUI
import Firebase

@main
struct pookie_checkerApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
                .preferredColorScheme(.light)
        }
    }
}
