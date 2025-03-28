//
//  WitAIService.swift
//  FinancialCalculator-wit-ai
//
//  Created by Amal Wickramarathna on 2025-03-24.
//
//
//import Foundation
//
//class WitAIService {
//    private let accessToken = "RJYAMWZ35AEEFOL7W5C6VU2QYZL6U4I5"
//    
//    func fetchWitAIResponse(for message: String, completion: @escaping (String) -> Void) {
//        let urlString = "https://api.wit.ai/message?v=20240318&q=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
//        guard let url = URL(string: urlString) else {
//            completion("Invalid URL.")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.httpMethod = "GET"
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                completion("Error connecting to AI.")
//                return
//            }
//
//            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//               let entities = json["entities"] as? [String: Any] {
//
//                // Extract values
//                let amount = (entities["amount"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
//                let interestRate = (entities["interest_rate"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
//                let duration = (entities["duration"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
//                
//                if amount > 0, interestRate > 0, duration > 0 {
//                    let result = self.calculateCompoundInterest(principal: amount, rate: interestRate, years: duration)
//                    completion("If you invest $\(amount) at \(interestRate)% for \(duration) years, you will get $\(result).")
//                } else {
//                    completion("I understood your question but couldn't find all the values needed.")
//                }
//            } else {
//                completion("I didn't understand, try again.")
//            }
//        }.resume()
//    }
//    
//    private func calculateCompoundInterest(principal: Double, rate: Double, years: Double, n: Double = 1) -> String {
//        let r = rate / 100  // Convert percentage to decimal
//        let amount = principal * pow(1 + (r / n), n * years)
//        return String(format: "%.2f", amount) // Format to 2 decimal places
//    }
//}


import Foundation

class WitAIService {
    private let accessToken = "RJYAMWZ35AEEFOL7W5C6VU2QYZL6U4I5" // 🔹 Replace with your actual Wit.ai token
    
    func fetchWitAIResponse(for message: String, completion: @escaping (String) -> Void) {
        let urlString = "https://api.wit.ai/message?v=20240318&q=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        guard let url = URL(string: urlString) else {
            completion("Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion("Error connecting to AI.")
                return
            }

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                
                print("Wit.ai Response: \(json)") // 🔹 Debugging: View full Wit.ai response
                
                if let entities = json["entities"] as? [String: Any], let traits = json["traits"] as? [String: Any] {
                    // ✅ Extract amount
                    let amountEntity = entities["wit$amount_of_money:amount_of_money"] as? [[String: Any]]
                    let amount = amountEntity?.first?["value"] as? Double ?? 0

                    // ✅ Extract interest rate
                    let interestRateEntity = entities["interest_rate:interest_rate"] as? [[String: Any]]
                    let interestRateString = interestRateEntity?.first?["value"] as? String ?? "0%"
                    let interestRate = Double(interestRateString.replacingOccurrences(of: "%", with: "")) ?? 0

                    // ✅ Extract duration
                    let durationEntity = entities["wit$duration:duration"] as? [[String: Any]]
                    let duration = durationEntity?.first?["value"] as? Double ?? 0

                    // ✅ Extract compounding frequency from `finance_compounding_frequency` trait
                    let frequencyTrait = traits["finance_compounding_frequency"] as? [[String: Any]]
                    let frequency = frequencyTrait?.first?["value"] as? String ?? "annually" // Default to annually

                    // 🔹 Debugging: Print extracted values
                    print("Extracted - Amount: \(amount), Interest Rate: \(interestRate), Duration: \(duration), Frequency: \(frequency)")

                    if amount > 0, interestRate > 0, duration > 0 {
                        let result = self.calculateCompoundInterest(principal: amount, rate: interestRate, years: duration, frequency: frequency)
                        completion("If you invest $\(amount) at \(interestRate)% for \(duration) years, compounded \(frequency), you will get $\(result).")
                    } else {
                        completion("I understood your question but couldn't find all the values needed.")
                    }
                } else {
                    completion("I didn't understand, try again.")
                }
            }
        }.resume()
    }

    // ✅ Compound Interest Calculation Supporting All Frequencies
    private func calculateCompoundInterest(principal: Double, rate: Double, years: Double, frequency: String) -> String {
        let r = rate / 100  // Convert percentage to decimal
        var n: Double = 1   // Default: Annually

        // 🔹 Set the correct compounding frequency
        switch frequency.lowercased() {
            case "annually":
                n = 1
            case "semi-annually":
                n = 2
            case "quarterly":
                n = 4
            case "monthly":
                n = 12
            case "daily":
                n = 365
            default:
                n = 1 // Default to annual if frequency is unknown
        }

        let amount = principal * pow(1 + (r / n), n * years)
        return String(format: "%.2f", amount) // 🔹 Format result to 2 decimal places
    }
}
