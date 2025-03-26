//
//  MainView.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-18.
//

//import SwiftUI
//
//struct MainContentView: View {
//
////    init() {
////        UITabBar
////            .appearance().backgroundColor = UIColor.clear // Removes default TabView background
////    }
//
//    var body: some View {
//        NavigationStack {
//            ZStack{
//                VStack(alignment: .leading) {
//                }
//                .frame(
//                    maxWidth: .infinity, maxHeight: .infinity,
//                    alignment: .topLeading
//                )
//                .navigationTitle("Finance Calculator")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        NavigationLink(destination: HelpContentView()) {
//                            Image(systemName: "gearshape.2.fill")
//                        }
//                    }
//                }
//
//                TabView {
//                    DashboardContentView()
//                        .tabItem {
//                            Image(systemName: "house.circle.fill")
//                            Text("Dashboard")
//                        }
//                    CompoundCalContentView()
//                        .tabItem {
//                            Image(systemName: "chart.bar.xaxis")
//                            Text("Compound")
//                        }
//
//                    SavingsCalContentView()
//                        .tabItem {
//                            Image(systemName: "banknote.fill")
//                            Text("Savings")
//                        }
//
//                    LoansCalContentView()
//                        .tabItem {
//                            Image(systemName: "creditcard.fill")
//                            Text("Loans")
//                        }
//                    MortgageCalContentView()
//                        .tabItem {
//                            Image(systemName: "house.fill")
//                            Text("Mortgage")
//                        }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    MainContentView()
//}

import SwiftUI

struct MainContentView: View {

    @State private var selectedTab = 0

    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    //                    DashboardContentView()
                    //                        .tabItem {
                    //                            Image(systemName: "house.circle.fill")
                    //                            Text("Dashboard")
                    //                        }

                    CompoundCalContentView()
                        .tabItem {
                            Image(systemName: "chart.bar.xaxis")
                            Text("Compound")
                        }

                    SavingsCalContentView()
                        .tabItem {
                            Image(systemName: "banknote.fill")
                            Text("Savings")
                        }

                    LoansCalContentView()
                        .tabItem {
                            Image(systemName: "creditcard.fill")
                            Text("Loans")
                        }

                    MortgageCalContentView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Mortgage")
                        }
                    //                    ChatBotContentView()
                    //                        .tabItem {
                    //                            Image(systemName: "bubble.left.and.bubble.right.fill")
                    //                            Text("ChatBot")
                    //                        }

//                    ChatBotContentView()
//                        .tabItem {
//                            Image(
//                                systemName: "bubble.left.and.bubble.right.fill"
//                            )
//                            .foregroundColor(selectedTab == 1 ? .blue : .gray)
//                            Text("ChatBot")
//                                .fontWeight(selectedTab == 1 ? .bold : .regular)
//                        }
//                        .tag(1)
                    
//                    ChatBotContentView()
//                        .tabItem {
//                            ZStack {
//                                if selectedTab == 1 {
//                                    Circle()
//                                        .fill(Color.blue.opacity(0.2))
//                                        .frame(width: 50, height: 50)
//                                }
//                                Image(systemName: "bubble.left.and.bubble.right.fill")
//                                    .foregroundColor(selectedTab == 1 ? .blue : .gray)
//                                Text("ChatBot")
//                                    .fontWeight(selectedTab == 1 ? .bold : .regular)
//                            }
//                        }
//                        .tag(1)
                    
                    
                    ChatBotContentView()
                        .tabItem {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                            Text("ChatBot")
                        }

                }
            }
            .navigationTitle("Wit.AI ")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: HelpContentView()) {
                        Image(systemName: "gearshape.2.fill")
                    }
                }
            }
        }
    }
}

#Preview {
    MainContentView()
}
