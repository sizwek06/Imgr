//
//  ContentViewModel.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import Foundation
import SwiftUI
import Photos

class ContentViewModel: NSObject, ObservableObject {
    
    var errorDescription: String = ""
    var errorCode: String = ""
    
    @Published var showingError = false
    @Published var viewState: ViewState = .loading
    
    private let photoAuthorizer: PhotoLibraryProtocol

    init(photoAuthorizer: PhotoLibraryProtocol = PhotoLibraryAuth()) {
        self.photoAuthorizer = photoAuthorizer
    }
    
    func requestPhotosPermissions() {
        self.requestPhotosAuth { status in
            switch status {
            case .authorized, .limited:
                self.setStatusOnMainThread(viewState: .accessGranted,
                                           errorState: false)
            case .restricted, .denied:
                self.setStatusOnMainThread(viewState: .photosPermissionDenied)
            case .notDetermined:
                self.setStatusOnMainThread(viewState: .photosPermissionUnknown)
            @unknown default:
                self.setStatusOnMainThread(viewState: .photosPermissionUnknown)
            }
        }
    }
    
    internal func requestPhotosAuth(_ completion: @escaping (PHAuthorizationStatus) -> Void) {
        photoAuthorizer.requestPhotosAuth { status in
            completion(status)
        }
    }
    
    func setStatusOnMainThread(viewState: ViewState, errorState: Bool = true) {
        DispatchQueue.main.async {
            self.viewState = viewState
            
            if errorState {
                self.provideErrorDetails()
                self.showingError = true
            } else {
                self.provideErrorDetails()
                // Sizwe K. - Added here so unit tests can hit the empty assignments.
                self.showingError = false
            }
        }
    }
    
    func provideErrorDetails() {
        
        switch self.viewState {
            
        case .accessGranted, .loading:
            self.errorCode = ""
            self.errorDescription = ""
        case .photosPermissionUnknown:
            self.errorCode = "0001"
            self.errorDescription = "Photos permission currently unknown, please allow access."
        case .photosPermissionDenied:
            self.errorCode = "0002"
            self.errorDescription = "Photos permission currently currently denied, please allow access in settings."
        }
    }
}

protocol PhotoLibraryProtocol {
    func requestPhotosAuth(_ completion: @escaping (PHAuthorizationStatus) -> Void)
}

