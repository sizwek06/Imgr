//
//  ImgrApp.swift
//  Imgr
//
//  Created by Sizwe Khathi on 2025/06/01.
//

import SwiftUI

@main
struct ImgrApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel())
        }
    }
}
