//
//  SplashViewModel.swift
//  TestTaskIOS
//
//  Created by Sergo on 28.01.2024.
//
import Foundation
class SplashViewModel {
    let titleText = "Notes"
    let createdByText = "Made by Sergey Chuiko"

    func proceedToMainViewController(completion: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion()
        }
    }
}
