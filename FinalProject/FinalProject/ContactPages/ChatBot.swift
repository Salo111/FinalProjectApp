//
//  ChatBot.swift
//  FinalProject
//
//  Created by salo khizanishvili on 14.09.22.
//

import SwiftUI

struct ChatBot: View {
    @State private var messageText = ""
    @State var messages: [String] = ["Welcome to MC 👋"]
    
    var body: some View {
        VStack {
            HStack {
                Text("MCChat")
                    .font(.largeTitle)
                    .bold()
                
                Image(systemName: "bubble.left.fill")
                    .font(.system(size: 26))
                    .foregroundColor(Color.purple)
            }
            
            ScrollView {
                ForEach(messages, id: \.self) { message in
                    // If the message contains [MySMS], it's mine
                    if message.contains("[MySMS]") {
                        let newMessage = message.replacingOccurrences(of: "[MySMS]", with: "")
                        
                        // My message
                        HStack {
                            Spacer()
                            Text(newMessage)
                                .padding()
                                .foregroundColor(Color.white)
                                .background(Color.purple.opacity(0.8))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                        }
                    }
                    else {
                        
                        // Bot message
                        HStack {
                            Text(message)
                                .padding()
                                .background(Color.gray.opacity(0.15))
                                .cornerRadius(10)
                                .padding(.horizontal, 16)
                                .padding(.bottom, 10)
                            Spacer()
                        }
                    }
                }.rotationEffect(.degrees(180))
            }
            .rotationEffect(.degrees(180))
            .background(Color.gray.opacity(0.1))
            
            // Contains the Message bar
            HStack {
                TextField("Type something", text: $messageText)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .onSubmit {
                        sendMessage(message: messageText)
                    }
                
                Button {
                    sendMessage(message: messageText)
                } label: {
                    Image(systemName: "paperplane.fill")
                        .foregroundColor(Color.purple)
                }
                .font(.system(size: 26))
                .padding(.horizontal, 10)
            }
            .padding()
        }
    }
    
    func sendMessage(message: String) {
        withAnimation {
            messages.append("[MySMS]" + message)
            self.messageText = ""
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    messages.append(GetBotAnswers(message: message))
                }
            }
        }
    }
}
