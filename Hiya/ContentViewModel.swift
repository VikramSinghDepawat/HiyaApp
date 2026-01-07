//
//  ContentViewModel.swift
//  Hiya
//
//  Created by Vikram Singh Depawat on 07/01/26.
//

import SwiftUI
import FoundationModels
import Combine

@MainActor
final class ContentViewModel: ObservableObject {
    
    private let model = SystemLanguageModel.default
    private let session = LanguageModelSession()
    
    @Published var response: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    var availabilityMessage: String? {
        switch model.availability {
        case .available:
            return nil
        case .unavailable(.deviceNotEligible):
            return "Your device is not eligible for Apple Intelligence."
        case .unavailable(.appleIntelligenceNotEnabled):
            return "Please enable Apple Intelligence in Settings."
        case .unavailable(.modelNotReady):
            return "AI model is not ready. Try again later."
        case .unavailable:
            return "Apple Intelligence is currently unavailable."
        }
    }
    
    var isAvailable: Bool {
        model.availability == .available
    }
    
    func generateResponse() async {
        guard !isLoading, isAvailable else { return }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            let prompt = "Say hi in a fun, friendly, and slightly playful way."
            let reply = try await session.respond(to: prompt)
            
            withAnimation {
                response = reply.content
            }
        } catch {
            errorMessage = error.localizedDescription
            response = ""
        }
    }
}
