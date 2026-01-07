//
//  ContentView.swift
//  Hiya
//
//  Created by Vikram Singh Depawat on 07/01/26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            
            content
            
            Spacer()
            
            actionButton
        }
        .padding()
        .tint(.purple)
    }
    
    // MARK: - Main Content
    @ViewBuilder
    private var content: some View {
        if let message = viewModel.availabilityMessage {
            Text(message)
                .font(.title3)
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        } else if viewModel.isLoading {
            ProgressView("Thinking…")
                .font(.title2)
        } else if let error = viewModel.errorMessage {
            Text("⚠️ \(error)")
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
        } else if viewModel.response.isEmpty {
            Text("Tap the button below to get a fun response ✨")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundStyle(.tertiary)
        } else {
            Text(viewModel.response)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
                .transition(.opacity.combined(with: .scale))
        }
    }
    
    // MARK: - Button
    private var actionButton: some View {
        Button {
            Task {
                await viewModel.generateResponse()
            }
        } label: {
            Text("Welcome")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .buttonStyle(.borderedProminent)
        .buttonSizing(.flexible)
        .glassEffect(.regular.interactive())
        .disabled(viewModel.isLoading || !viewModel.isAvailable)
        .opacity(viewModel.isLoading ? 0.6 : 1)
    }
}

#Preview {
    ContentView()
}
