//
//  MainTabView.swift
//  studyBudy
//
//  Created by José Ruiz on 22/10/24.
//



import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @StateObject private var examViewModel = ExamProgressViewModel()
    
    init() {
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground 
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        NavigationStack{
            TabView(selection: $selectedTab) {
                HomeView()
                    .tabItem {
                        Label("Inicio", systemImage: "house.fill")
                    }
                    .tag(0)
                ExamProgressPieChartView(examViewModel: examViewModel)
                    .tabItem {
                        Label("Aprendizaje", systemImage: "book.fill")
                    }
                    .tag(1)
                
                ChatView(selectedTab: $selectedTab, isTabViewNavigation: true)
                    .tabItem {
                        Label("Budy AI", systemImage: "person.2.fill")
                    }
                    .tag(2)
                
                FlashCards()
                    .tabItem {
                        Label("Aprendizaje", systemImage: "book.fill")
                    }
                    .tag(3)
            }
            .toolbarBackground(.clear, for: .tabBar)
        }
        .toolbarBackground(.clear, for: .navigationBar)
       
    }
}

#Preview {
    MainTabView()
}


