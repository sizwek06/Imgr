//
//  ViewState.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import Photos

enum ViewState: Equatable {
    case loading
    case accessGranted
    case photosPermissionDenied
    case photosPermissionUnknown
    
    var isPermissionError: Bool {
        self == .photosPermissionUnknown || self == .photosPermissionDenied
    }
}

struct PhotoLibraryAuth: PhotoLibraryProtocol {
    func requestPhotosAuth(_ completion: @escaping (PHAuthorizationStatus) -> Void) {
        PHPhotoLibrary.requestAuthorization { status in
            completion(status)
        }
    }
}
