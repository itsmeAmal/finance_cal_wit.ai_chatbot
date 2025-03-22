//
//  Cal2.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-18.
//

//import SwiftUI
//
//struct CompoundCalContentView: View {
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
//    CompoundCalContentView()
//}

import SwiftUI

struct CompoundCalContentView: View {
    @State private var principal: String = ""  // PV
    @State private var interestRate: String = ""  // r (percentage)
    @State private var years: Double = 1  // t
    @State private var selectedFrequency = 12  // Default to Monthly Compounding
    @State private var futureValue: Double? = nil  // FV Result

    let compoundingFrequencies = [
        "Annually": 1,
        "Semi-Annually": 2,
        "Quarterly": 4,
        "Monthly": 12,
        "Daily": 365,
    ]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray
                    .opacity(0.2)
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 20) {
                    Text("Compound Interest Calculator")
                        .font(.subheadline)
                        .bold()

                    // Input: Principal Amount
                    HStack {
                        Text("Initial Investment ($):")
                        TextField("Enter amount", text: $principal)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // Input: Interest Rate
                    HStack {
                        Text("Annual Interest Rate (%):")
                        TextField("Enter rate", text: $interestRate)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }

                    // Input: Number of Years (Stepper)
                    HStack {
                        Text("Number of Years:")
                        Stepper(
                            "\(Int(years))",
                            value: $years,
                            in: 1...50,
                            step: 1
                        )
                    }

                    // Input: Compounding Frequency (Picker)
                    Picker(
                        "Compounding Frequency",
                        selection: $selectedFrequency
                    ) {
                        ForEach(
                            compoundingFrequencies
                                .sorted(by: { $0.value < $1.value }),
                            id: \.key
                        ) { key, value in
                            Text(key).tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

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
                        Text("Future Value: $\(fv, specifier: "%.2f")")
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

    // Function to Calculate Future Value (FV)
    func calculateFutureValue() {
        guard let p = Double(principal),
            let r = Double(interestRate)
        else {
            return
        }

        let n = Double(selectedFrequency)  // Compounding frequency
        let t = years
        let rate = r / 100  // Convert percentage to decimal

        // Apply Compound Interest Formula
        let fv = p * pow(1 + (rate / n), n * t)
        futureValue = fv  // Store result
    }
}

#Preview {
    CompoundCalContentView()
}
