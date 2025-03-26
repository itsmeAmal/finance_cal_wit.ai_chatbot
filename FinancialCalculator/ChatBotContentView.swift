//
//  ChatBotContentView.swift
//  FinancialCalculator-wit-ai
//
//  Created by Amal Wickramarathna on 2025-03-22.
//
//
//import SwiftUI
//
//struct ChatBotContentView: View {
//    @State private var userInput = ""
//    @State private var messages: [ChatMessage] = [
//        ChatMessage(text: "Hello! How can I help with your financial calculations?", isUser: false)
//    ]
//
//    var body: some View {
//        VStack {
//            // Chat Header
//            Text("Finance Chatbot")
//                .font(.title)
//                .bold()
//                .padding()
//
//            // Chat Messages List
//            ScrollView {
//                VStack(alignment: .leading, spacing: 10) {
//                    ForEach(messages) { message in
//                        ChatBubble(message: message)
//                    }
//                }
//                .padding()
//            }
//
//            // Input Field & Send Button
//            HStack {
//                TextField("Type a message...", text: $userInput)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .frame(height: 40)
//
//                Button(action: {
//                    sendMessage()
//                }) {
//                    Image(systemName: "paperplane.fill")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .clipShape(Circle())
//                }
//            }
//            .padding()
//        }
//    }
//
//    // Function to Send User Input to Wit.ai
//    func sendMessage() {
//        let userMessage = ChatMessage(text: userInput, isUser: true)
//        messages.append(userMessage) // Add user's message
//        fetchWitAIResponse(for: userInput) { response in
//            let botMessage = ChatMessage(text: response, isUser: false)
//            DispatchQueue.main.async {
//                messages.append(botMessage) // Add bot's response
//            }
//        }
//        userInput = "" // Clear input field
//    }
//
//    // Function to Fetch AI Response from Wit.ai
//    func fetchWitAIResponse(for message: String, completion: @escaping (String) -> Void) {
//        let accessToken = "YOUR_WIT_AI_ACCESS_TOKEN"
//        let urlString = "https://api.wit.ai/message?v=20240318&q=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
//        var request = URLRequest(url: URL(string: urlString)!)
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
//                completion("I understood: \(entities)")
//            } else {
//                completion("I didn't understand, try again.")
//            }
//        }.resume()
//    }
//}
//
//// Model for Chat Messages
//struct ChatMessage: Identifiable {
//    let id = UUID()
//    let text: String
//    let isUser: Bool
//}
//
//// Chat Bubble UI
//struct ChatBubble: View {
//    let message: ChatMessage
//
//    var body: some View {
//        HStack {
//            if message.isUser { Spacer() }
//            Text(message.text)
//                .padding()
//                .background(message.isUser ? Color.blue : Color.gray.opacity(0.3))
//                .foregroundColor(message.isUser ? .white : .black)
//                .cornerRadius(10)
//            if !message.isUser { Spacer() }
//        }
//    }
//}
//
//#Preview {
//    ChatBotContentView()
//}


import SwiftUI

struct ChatBotContentView: View {
    @State private var userInput = ""
    @State private var messages: [ChatMessage] = [
        ChatMessage(text: "Hello! Ask me about finance calculations.", isUser: false)
    ]
    
    let witAIService = WitAIService()

    var body: some View {
        VStack {
            Text("Finance Chatbot")
                .font(.title)
                .bold()
                .padding()

            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(messages) { message in
                        ChatBubble(message: message)
                    }
                }
                .padding()
            }

            HStack {
                TextField("Ask a question...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(height: 40)

                Button(action: {
                    sendMessage()
                }) {
                    Image(systemName: "paperplane.fill")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            .padding()
        }
    }

    func sendMessage() {
        let userMessage = ChatMessage(text: userInput, isUser: true)
        messages.append(userMessage)

        witAIService.fetchWitAIResponse(for: userInput) { response in
            let botMessage = ChatMessage(text: response, isUser: false)
            DispatchQueue.main.async {
                messages.append(botMessage)
            }
        }
        userInput = ""
    }
}

// Chat Message Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

// Chat Bubble UI
struct ChatBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            Text(message.text)
                .padding()
                .background(message.isUser ? Color.blue : Color.gray.opacity(0.3))
                .foregroundColor(message.isUser ? .white : .black)
                .cornerRadius(10)
            if !message.isUser { Spacer() }
        }
    }
}

#Preview {
    ChatBotContentView()
}
