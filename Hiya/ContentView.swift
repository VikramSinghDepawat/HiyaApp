//
//  ContentView.swift
//  Hiya
//
//  Created by Vikram Singh Depawat on 07/01/26.
//

import SwiftUI
import FoundationModels

struct ContentView: View {
    private var largeLanguageModel = SystemLanguageModel.default
    private var session = LanguageModelSession()

    @State private var response = ""
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            
            switch largeLanguageModel.availability {
            case .available:
                if response.isEmpty {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Tap the button below to get a fun response")
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .foregroundStyle(.tertiary)
                    }
                } else {
                    Text(response)
                        .multilineTextAlignment(.center)
                        .font(.largeTitle)
                        .bold()
                }
            case .unavailable(.deviceNotEligible):
                Text("Your device is not eligible for Apple Intelligence.")
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Please enable Apple Intelligence in Settings.")
            case .unavailable(.modelNotReady):
                Text("AI model is not ready.")
            case .unavailable:
                Text("Unavailable")
            }
            
            Spacer()
            
            Button {
                Task {
                    isLoading = true
                    
                    defer {
                        isLoading = false
                    }
                    
                    let prompt = "Say hi in a fun way."
                    
                    do {
                        let reply = try await session.respond(to: prompt)
                        response = reply.content
                    } catch {
                        response = "Failed to get response: \(error.localizedDescription)"
                    }
                }
            } label: {
                Text("Welcome")
                    .font(.largeTitle)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .buttonSizing(.flexible)
            .glassEffect(.regular.interactive())
        }
        .padding()
        .tint(.purple)
    }
}

#Preview {
    ContentView()
}
