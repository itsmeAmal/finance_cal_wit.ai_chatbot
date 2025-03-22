//
//  PercentageCalculator.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-18.
//

//import SwiftUI
//
//struct SavingsCalContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!, this is percentage calculator ")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    SavingsCalContentView()
//}
import SwiftUI

struct SavingsCalContentView: View {
    @State private var monthlyContribution: String = "" // P
    @State private var interestRate: String = "" // r (percentage)
    @State private var years: Double = 1 // t
    @State private var futureValue: Double? = nil // FV Result
    
    let compoundingFrequency = 12 // Monthly Compounding

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.2)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Savings Calculator")
                        .font(.subheadline)
                        .bold()

                    // Input: Monthly Contribution
                    HStack {
                        Text("Monthly Contribution ($):")
                        Spacer()
                        TextField("Enter amount", text: $monthlyContribution)
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

                    // Input: Number of Years (Stepper)
                    HStack {
                        Text("Number of Years:")
                        Spacer()
                        Stepper("\(Int(years))", value: $years, in: 1...50, step: 1)
                    }

                    // Calculate Button
                    Button(action: calculateFutureValue) {
                        Text("Calculate")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // Display Result
                    if let fv = futureValue {
                        Text("Total Savings: $\(fv, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                            .padding()
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                    }
                    
                    Spacer() // Pushes content up
                }
                .padding()
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 100)
            .padding(.bottom, 100)
        }
    }
    
    // Function to Calculate Future Value
    func calculateFutureValue() {
        guard let P = Double(monthlyContribution),
              let r = Double(interestRate) else {
            return
        }

        let n = Double(compoundingFrequency) // Monthly compounding
        let t = years
        let rate = r / 100 // Convert percentage to decimal

        // Apply Savings Future Value Formula
        let fv = P * ((pow(1 + (rate / n), n * t) - 1) / (rate / n))
        futureValue = fv // Store result
    }
}

#Preview {
    SavingsCalContentView()
}
