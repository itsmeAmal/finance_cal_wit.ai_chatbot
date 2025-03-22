//
//  MortgageCalContentView.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-18.
//


//import SwiftUI
//
//struct MortgageCalContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!, this is cal 2 ")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    MortgageCalContentView()
//}

import SwiftUI

struct MortgageCalContentView: View {
    @State private var homePrice: String = "" // Total Home Price
    @State private var downPayment: String = "" // Down Payment
    @State private var interestRate: String = "" // Annual Rate in %
    @State private var loanTerm: Double = 1 // Years
    @State private var monthlyPayment: Double? = nil // PMT Result

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2) //
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Mortgage Calculator")
                        .font(.subheadline)
                        .bold()

                    // Input: Home Price
                    HStack {
                        Text("Home Price ($):")
                        Spacer()
                        TextField("Enter amount", text: $homePrice)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }

                    // Input: Down Payment
                    HStack {
                        Text("Down Payment ($):")
                        Spacer()
                        TextField("Enter amount", text: $downPayment)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                    }

                    // Input: Interest Rate
                    HStack {
                        Text("Annual Interest Rate (%):")
                        Spacer()
                        TextField("Enter rate", text: $interestRate)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 100)
                    }

                    // Input: Loan Term (Stepper)
                    HStack {
                        Text("Loan Term (Years):")
                        Spacer()
                        Stepper("\(Int(loanTerm))", value: $loanTerm, in: 1...30, step: 1)
                    }

                    // Calculate Button
                    Button(action: calculateMortgagePayment) {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // Display Result
                    if let pmt = monthlyPayment {
                        Text("Monthly Payment: $\(pmt, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                    }

                    Spacer()
                }
                .padding()
            }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 100)
                .padding(.bottom, 100)
        }
    }
    
    // Function to Calculate Mortgage Payment (PMT)
    func calculateMortgagePayment() {
        guard let homeP = Double(homePrice),
              let downP = Double(downPayment),
              let r = Double(interestRate) else {
            return
        }

        let P = homeP - downP // Loan Amount = Home Price - Down Payment
        let monthlyRate = (r / 100) / 12 // Convert annual % to monthly decimal
        let n = loanTerm * 12 // Convert years to months

        // Apply Mortgage Payment Formula
        if monthlyRate == 0 {
            monthlyPayment = P / n // No interest case
        } else {
            monthlyPayment = P * (monthlyRate * pow(1 + monthlyRate, n)) / (pow(1 + monthlyRate, n) - 1)
        }
    }
}

#Preview {
    MortgageCalContentView()
}

