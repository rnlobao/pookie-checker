//
//  LogEntry.swift
//  pookie-checker
//
//  Created by Robson Novato on 16/09/24.
//

import Foundation
import SwiftUI
import AppIntents

struct LogEntry: AppIntent {
    static var title: LocalizedStringResource = "Log a streak"
    static var description: IntentDescription = IntentDescription("Aciona o gato")
    
    func perform() async throws -> some IntentResult {
        UserDefaults.standard.setValue(1, forKey: "abc")
        return .result(value: UserDefaults.standard.value(forKey: "abc"))
    }
}
