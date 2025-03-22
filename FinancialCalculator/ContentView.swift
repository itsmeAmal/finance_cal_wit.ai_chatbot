//
//  ContentView.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-17.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}


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

struct ContentView: View {
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
                }
            }
            .navigationTitle("Finance Calculator")
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
    ContentView()
}
