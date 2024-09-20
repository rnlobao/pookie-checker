//
//  InterWidget.swift
//  InterWidget
//
//  Created by Robson Novato on 14/09/24.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), quantidaDeMoedas: 1)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), quantidaDeMoedas: 1)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, quantidaDeMoedas: 1)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    var date: Date
    let quantidaDeMoedas: Int
}

struct InterWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        HStack {
            // Botão na esquerda
            Button(action: {
                print("Botão clicado!")
            }) {
                Text("Clique Aqui")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            Spacer()
            
            // Imagem na direita
            Image(systemName: "photo")
                .resizable()
                .frame(width: 100, height: 100)
                .padding()
        }
        .padding()
    }
}

struct InterWidget: Widget {
    let kind: String = "InterWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                InterWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                InterWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    InterWidget()
} timeline: {
    SimpleEntry(date: .now, quantidaDeMoedas: 1)
}
