//
//  ContentView.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                Group {
                    switch viewModel.viewState {
                    case .accessGranted:
                        ImageView()
                    case .loading, .photosPermissionUnknown, .photosPermissionDenied:
                        LoadingView()
                    }
                }
            }
            .onAppear {
                self.viewModel.requestPhotosPermissions()
            }
            .sheet(isPresented: $viewModel.showingError, onDismiss: {
                if viewModel.viewState.isPermissionError {
                    viewModel.showingError = true
                }
            }) {
                ErrorView(
                    isPresented: $viewModel.showingError,
                    errorTitle: viewModel.errorCode,
                    errorDescription: viewModel.errorDescription,
                    viewState: viewModel.viewState
                )
            }
        }
    }

}

#Preview {
    ContentView(viewModel: ContentViewModel())
}
