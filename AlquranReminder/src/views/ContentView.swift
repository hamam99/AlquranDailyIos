//
//  ContentView.swift
//  AlquranReminder
//
//  Created by Hamam Nasrodin on 30/08/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {

        ZStack {
            TabView {
                DashboardView().tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                SurahView().tabItem {
                    Image(systemName: "book")
                    Text("Surah")
                }
                StatsView().tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
                ProfileView().tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
            }
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
