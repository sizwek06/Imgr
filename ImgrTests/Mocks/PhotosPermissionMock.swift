//
//  PhotosPermissionMock.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import Photos

class PhotosPermissionMock: PhotoLibraryProtocol {
    
    var mockStatus: PHAuthorizationStatus = .notDetermined
    
    func requestPhotosAuth(_ completion: @escaping (PHAuthorizationStatus) -> Void) {
        completion(mockStatus)
    }
    
    func returnPhotosAuth() -> ViewState {
        switch mockStatus {
        case .authorized, .limited:
            return .accessGranted
        case .denied, .restricted:
            return .photosPermissionDenied
        case .notDetermined:
            return .photosPermissionUnknown
        @unknown default:
            return .photosPermissionUnknown
        }
    }
}
