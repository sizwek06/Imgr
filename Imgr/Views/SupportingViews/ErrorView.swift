//
//  ErrorView.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import SwiftUI

struct ErrorView: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var errorTitle: String
    var errorDescription: String
    var viewState: ViewState
    
    init(isPresented: Binding<Bool>, errorTitle: String, errorDescription: String, viewState: ViewState) {
        
        self._isPresented = isPresented
        self.errorTitle = errorTitle
        self.errorDescription = errorDescription
        self.viewState = viewState
    }
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 95.0, height: 95.0)
                .foregroundColor(.red)
            Text(self.errorTitle)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .frame(alignment: .center)
                .frame(width: 100,
                       alignment: .top)
            Text(self.errorDescription)
                .font(.title3)
                .multilineTextAlignment(.center)
                .frame(alignment: .center)
                .frame(width: 300,
                       height: UIScreen.main.bounds.height / 3,
                       alignment: .top)
            if viewState.isPermissionError {
                Button(action: {
                    if let imgrSettings = URL(string: UIApplication.openSettingsURLString) {
                           if UIApplication.shared.canOpenURL(imgrSettings) {
                               UIApplication.shared.open(imgrSettings)
                           }
                       }
                }) {
                    HStack {
                            Text("Access Photos Settings")
                            Image(systemName: "arrow.right")
                        }
                        .padding(.all, 25)
                        .foregroundColor(.white)
                        .background(.red)
                        .cornerRadius(100)
                        .accessibilityIdentifier("SettingsButton")
                }
            }
        }
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview {
    struct Preview: View {
            @State var bool = true
            var body: some View {
                ErrorView(isPresented: $bool,
                          errorTitle: "003",
                          errorDescription: "Preview Error: Additional Text for multiline",
                          viewState: .photosPermissionUnknown)
            }
        }

        return Preview()
}
