//
//  CreateNoteViewController.swift
//  TestTaskIOS
//
//  Created by Sergo on 27.01.2024.
//

import UIKit

protocol CreateNoteDelegate: AnyObject {
    func didCreateNote(title: String, content: String)
    func didEditNote(_ editedNote: Note)
}

class CreateNoteViewController: UIViewController {
    var editingNoteIndex: Int?
    var noteToEdit: Note?
    weak var delegate: CreateNoteDelegate?

    private let titleLabel: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Заголовок"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10.0
        textField.font = UIFont.boldSystemFont(ofSize: 26)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        return textField
    }()

    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white
        textView.layer.cornerRadius = 10.0
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.black
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navBarSettings()
        configureWithNote()
        setupTapGestureToDismissKeyboard()
    }

    //MARK: - Methods
    private func setupTapGestureToDismissKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    private func configureWithNote() {
        if let noteToEdit = noteToEdit {
            titleLabel.text = noteToEdit.title
            contentTextView.text = noteToEdit.content
        }
    }

    private func navBarSettings() {
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveNote))
        saveButton.tintColor = UIColor(red: 1.0, green: 0.6, blue: 0.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.tintColor = UIColor(named: "customYellow-color")
    }

    private func setupUI() {
        titleLabel.delegate = self
        contentTextView.delegate = self
        view.addSubview(titleLabel)
        view.addSubview(contentTextView)
        view.backgroundColor = .systemGray5
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            contentTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            contentTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            contentTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            contentTextView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }

    //MARK: - @objc Methods
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func saveNote() {
        guard let title = titleLabel.text, !title.isEmpty,
              let content = contentTextView.text else {
            return
        }
        if var noteToEdit = noteToEdit {
            noteToEdit.title = title
            noteToEdit.content = content
            delegate?.didEditNote(noteToEdit)
        } else {
            delegate?.didCreateNote(title: title, content: content)
        }
        navigationController?.popViewController(animated: true)
    }
}

extension CreateNoteViewController: UITextFieldDelegate, UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleLabel {
            contentTextView.becomeFirstResponder()
        } else if textField == contentTextView {
            saveNote()
        }
        return true
    }
}
