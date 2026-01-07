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
    @State private var response = ""
    var body: some View {
        VStack {
            switch largeLanguageModel.availability {
            case .available:
                Text("Available")
            case .unavailable(.deviceNotEligible):
                Text("Your device is not eligible for Apple Intelligence.")
            case .unavailable(.appleIntelligenceNotEnabled):
                Text("Please enable Apple Intelligence in Settings.")
            case .unavailable(.modelNotReady):
                Text("AI model is not ready.")
            case .unavailable:
                Text("Unavailable")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
