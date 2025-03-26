//
//  WitAIService.swift
//  FinancialCalculator-wit-ai
//
//  Created by Amal Wickramarathna on 2025-03-24.
//

import Foundation

class WitAIService {
    private let accessToken = "RJYAMWZ35AEEFOL7W5C6VU2QYZL6U4I5"
    
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

            if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let entities = json["entities"] as? [String: Any] {

                // Extract values
                let amount = (entities["amount"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
                let interestRate = (entities["interest_rate"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
                let duration = (entities["duration"] as? [[String: Any]])?.first?["value"] as? Double ?? 0
                
                if amount > 0, interestRate > 0, duration > 0 {
                    let result = self.calculateCompoundInterest(principal: amount, rate: interestRate, years: duration)
                    completion("If you invest $\(amount) at \(interestRate)% for \(duration) years, you will get $\(result).")
                } else {
                    completion("I understood your question but couldn't find all the values needed.")
                }
            } else {
                completion("I didn't understand, try again.")
            }
        }.resume()
    }
    
    private func calculateCompoundInterest(principal: Double, rate: Double, years: Double, n: Double = 1) -> String {
        let r = rate / 100  // Convert percentage to decimal
        let amount = principal * pow(1 + (r / n), n * years)
        return String(format: "%.2f", amount) // Format to 2 decimal places
    }
}
