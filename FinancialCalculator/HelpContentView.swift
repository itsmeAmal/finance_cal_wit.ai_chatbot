//
//  Help.swift
//  FinancialCalculator
//
//  Created by Amal Wickramarathna on 2025-03-18.
//

import SwiftUI

struct HelpContentView: View {
    @State private var expandedItem: String? = nil  // Tracks which item is expanded
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 10) {
                // Expandable List Items
                ForEach(helpItems, id: \.title) { item in
                    DisclosureGroup(
                        isExpanded: Binding(
                            get: { expandedItem == item.title },
                            set: { newValue in
                                expandedItem = newValue ? item.title : nil
                            }
                        )
                    ) {
                        Text(item.description)
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                    } label: {
                        Text(item.title)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Help")
        }
    }
}

struct HelpItem {
    let title: String
    let description: String
}

//Help Content
let helpItems: [HelpItem] = [
    HelpItem(title: "Compound Interest Savings", description: "The Compound Interest Calculator helps you estimate the future value of an investment by applying interest over time. To use this calculator, enter your initial investment amount, select the annual interest rate, and choose the number of years you plan to invest. Additionally, select how often the interest is compounded (e.g., monthly, quarterly, or annually). Once all values are entered, tap Calculate to see the expected total amount at the end of the investment period. This is useful for long-term savings and investment planning."),
    HelpItem(title: "Savings with Monthly Contributions", description: "This calculator helps estimate how much you will save over time if you make regular monthly deposits into an interest-bearing account. To use it, enter your monthly savings contribution, set the annual interest rate, and specify how many years you plan to save. The app will automatically assume monthly compounding. Press Calculate, and the calculator will show the total savings accumulated, including interest, over time. This is ideal for users planning systematic savings or retirement funds."),
    HelpItem(title: "Loans", description: "The Loan Calculator allows you to calculate your monthly repayment amount when taking out a loan. To use this feature, enter the loan amount you are borrowing, specify the annual interest rate, and choose the loan term (in years). After entering these values, tap Calculate to determine your monthly installment. This calculator is useful for understanding how much you need to pay each month for a personal loan, car loan, or student loan."),
    HelpItem(title: "Mortgage", description: "The Mortgage Calculator helps determine your monthly mortgage payment for a home loan. Start by entering the total home price, followed by the down payment (the amount you pay upfront). Next, input the annual interest rate and specify the loan term in years. Once all values are entered, tap Calculate to see your estimated monthly mortgage payment. This tool is essential for home buyers looking to understand their financial commitment before purchasing a property.")
]

#Preview {
    HelpContentView()
}
