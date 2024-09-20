//
//  pookie_checkerApp.swift
//  pookie-checker
//
//  Created by Robson Novato on 12/08/24.
//

import SwiftUI

@main
struct pookie_checkerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel())
        }
    }
}
