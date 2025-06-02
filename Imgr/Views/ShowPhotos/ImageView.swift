//
//  ImageView.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import SwiftUI

struct ImageView: View {
    @State private var showPhotoAlbum = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Spacer()
                assignImage()
                    .scaledToFit()
                    .frame(height: selectedImage != nil ? 300 : 200)
                // Add share button & others?
                Spacer()
            }
            .sheet(isPresented: $showPhotoAlbum) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
        .navigationTitle("Imgr")
        .navigationBarTitleDisplayMode(.large)
    }
    
    @ViewBuilder
    func assignImage() -> some View {
        if let image = selectedImage {
            Image(uiImage: image)
                .resizable()
        } else {
            Image(systemName: "photo")
                .resizable()
                .foregroundStyle(.indigo)
        }
    }
}

#Preview  {
    ImageView()
}

