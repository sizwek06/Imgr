//
//  LoadingView.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import SwiftUI

struct LoadingView: View {
    
    @State private var isRotating = 0.0
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: "photo.stack.fill")
                .resizable()
                .frame(width: 200,
                       height: 200)
                .foregroundColor(.indigo)
            ProgressView()
                .progressViewStyle(.circular)
                .rotationEffect(.degrees(isRotating))
                .scaleEffect(2)
                .tint(.indigo)
                .padding(.top, 25)
            Text("Imgr v1.0.0")
                .accessibilityIdentifier("LoadingLabel")
                .font(.headline)
                .padding(.top, 150)
                .frame(width: UIScreen.main.bounds.width - 20,
                       height: UIScreen.main.bounds.height / 20,
                       alignment: .center)
                .foregroundStyle(.indigo)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
