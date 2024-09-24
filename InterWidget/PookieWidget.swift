//
//  InterWidget.swift
//  InterWidget
//
//  Created by Robson Novato on 14/09/24.
//

import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
            SimpleEntry(date: Date(), quantidaDeMoedas: 1, imagem: "antes")
        }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
            let entry = SimpleEntry(date: Date(), quantidaDeMoedas: 1, imagem: "antes")
            completion(entry)
        }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = SimpleEntry(date: currentDate, quantidaDeMoedas: 1, imagem: "antes")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let quantidaDeMoedas: Int
    let imagem: String
}

struct PookieWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            Image(entry.imagem)
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
            
            Spacer()
            
            Button(action: {
                Task {
                    let intent = AddIntent()
                    _ = try await intent.perform() // Executa a intent
                }
            }) {
                Text("Clique Aqui")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .preferredColorScheme(.light)
    }
}

struct PookieWidget: Widget {
    let kind: String = "InterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PookieWidgetEntryView(entry: entry)
                .padding()
                .background()
        }
    }
}

extension Notification.Name {
    static let changeImageToCat = Notification.Name("changeImageToCat")
}


struct AddIntent: AppIntent {
    static var title: LocalizedStringResource = "Mudar Imagem"
    
    func perform() async throws -> some IntentResult {
        // Força a atualização de todos os timelines de widget
        WidgetCenter.shared.reloadAllTimelines()
        return .result()
    }
}

#Preview(as: .systemMedium) {
    PookieWidget()
} timeline: {
    SimpleEntry(date: .now, quantidaDeMoedas: 1, imagem: "antes")
}


