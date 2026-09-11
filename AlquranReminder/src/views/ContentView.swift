//
//  ContentView.swift
//  AlquranReminder
//
//  Created by Hamam Nasrodin on 30/08/2026.
//

import SwiftData
import SwiftUI

struct ContentView: View {
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
}

#Preview {
    ContentView()
}
