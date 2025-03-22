////
////  DashboardContentView.swift
////  FinancialCalculator
////
////  Created by Amal Wickramarathna on 2025-03-19.
////
//
////import SwiftUI
////
////struct DashboardContentView: View {
////    var body: some View {
////        VStack {
////            Image(systemName: "globe")
////                .imageScale(.large)
////                .foregroundStyle(.tint)
////            Text("Hello, world!, this is cal 2 ")
////        }
////        .padding()
////    }
////}
////
////#Preview {
////    DashboardContentView()
////}
//
//import SwiftUI
//
//struct DashboardContentView: View {
//    let tiles = [
//        (
//            "chart.bar.xaxis", "Compound Interest",
//            "Calculate investment growth."
//        ),
//        ("banknote.fill", "Savings", "Estimate future savings."),
//        ("creditcard.fill", "Loans", "Plan loan repayments."),
//        ("house.fill", "Mortgage", "Calculate monthly mortgage payments."),
//    ]
//
//    var body: some View {
//        ZStack{
//            Rectangle()
//                    .fill(Color(red: 229/255, green: 0/255, blue: 70/255))
//                    .ignoresSafeArea()
//            NavigationStack {
//                VStack {
//                    Text("Finance Dashboard")
//                        .font(.title)
//                        .bold()
//                        .padding(.top, 20)
//
//                    TabView {
//                        ForEach(tiles, id: \.0) { tile in
//                            TileView(
//                                icon: tile.0, title: tile.1, description: tile.2)
//                        }
//                    }
//                    .tabViewStyle(.page)
//                    .frame(height: 200)
//
//                    Spacer()
//                }
//                .padding()
//            }
//        }
//    }
//}
//
//struct TileView: View {
//    let icon: String
//    let title: String
//    let description: String
//
//    var body: some View {
//        VStack {
//            Image(systemName: icon)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//                .foregroundColor(.blue)
//
//            Text(title)
//                .font(.headline)
//                .bold()
//
//            Text(description)
//                .font(.subheadline)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal)
//
//        }
//        .frame(width: 300, height: 150)
//        .background(Color.white)
//        .cornerRadius(15)
//        .shadow(radius: 5)
//        .padding()
//    }
//}
//
//#Preview {
//    DashboardContentView()
//}


import SwiftUI

struct DashboardContentView: View {
    let tiles = [
        ("chart.bar.xaxis", "Compound Interest", "Calculate investment growth."),
        ("banknote.fill", "Savings", "Estimate future savings."),
        ("creditcard.fill", "Loans", "Plan loan repayments."),
        ("house.fill", "Mortgage", "Calculate monthly mortgage payments."),
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 87/255, green: 180/255, blue: 186/255)
                    .ignoresSafeArea()

                VStack {
                     

                    TabView {
                        ForEach(tiles, id: \.0) { tile in
                            TileView(icon: tile.0, title: tile.1, description: tile.2)
                        }
                    }
                    .tabViewStyle(.page)
                    .frame(height: 200)

                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct TileView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.black)

            Text(description)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal)

        }
        .frame(width: 300, height: 150)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.bottom, 30)
    }
}

#Preview {
    DashboardContentView()
}
