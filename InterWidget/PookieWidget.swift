import WidgetKit
import SwiftUI
import AppIntents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> PookieWidgetEntry {
        PookieWidgetEntry(date: Date(), quantidaDeMoedas: 1, imagem: "antes")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (PookieWidgetEntry) -> ()) {
        let entry = PookieWidgetEntry(date: Date(), quantidaDeMoedas: 1, imagem: "antes")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let currentDate = Date()
        let entry = PookieWidgetEntry(date: currentDate, quantidaDeMoedas: 1, imagem: "antes")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct PookieWidgetEntry: TimelineEntry {
    var date: Date
    let quantidaDeMoedas: Int
    let imagem: String
}

struct PookieWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            Color.clear
                .ignoresSafeArea()
            
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
}

struct PookieWidget: Widget {
    let kind: String = "InterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                PookieWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
                    .preferredColorScheme(.light)
            } else {
                PookieWidgetEntryView(entry: entry)
                    .padding()
                    .background()
                    .preferredColorScheme(.light)
            }
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
    PookieWidgetEntry(date: .now, quantidaDeMoedas: 1, imagem: "antes")
}


