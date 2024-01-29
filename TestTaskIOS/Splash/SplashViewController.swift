//
//  SplashViewController.swift
//  TestTaskIOS
//
//  Created by Sergo on 28.01.2024.
//

import UIKit

class SplashViewController: UIViewController {
    let viewModel = SplashViewModel()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.text = "Notes"
        label.textColor = UIColor(named: "customYellow-color")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let createdByLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Made by Sergey Chuiko"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureLabels()
        viewModel.proceedToMainViewController {
            self.showMainViewController()
        }
    }

    //MARK: - Methods
    private func configureLabels() {
        titleLabel.text = viewModel.titleText
        createdByLabel.text = viewModel.createdByText
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(createdByLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            createdByLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createdByLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    private func showMainViewController() {
        let mainViewController = UINavigationController(rootViewController: NoteViewController())
        mainViewController.modalPresentationStyle = .fullScreen
        mainViewController.modalTransitionStyle = .crossDissolve
        present(mainViewController, animated: true)
    }
}
