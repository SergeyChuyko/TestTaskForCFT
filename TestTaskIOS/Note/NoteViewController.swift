//
//  NoteViewController.swift
//  TestTaskIOS
//
//  Created by Sergo on 27.01.2024.
//

import UIKit

class NoteViewController: UIViewController {
    var notes: [Note] = []
    var selectedNoteIndex: Int?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Заметки"
        setupUI()
        testNote()
        navBarSettings()
        loadNotesFromUserDefaults()
    }

//MARK: - Methods
    func showDeleteAlert(indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Удалить заметку?", message: .none, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { (action) in
            self.notes.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.saveNotesToUserDefaults()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        present(alertController, animated: true, completion: nil)
    }

    private func navBarSettings() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        addButton.tintColor = UIColor(named: "customYellow-color")
        navigationItem.rightBarButtonItem = addButton
    }

    private func testNote() {
        print("Создаю новую тестовую заметку")
        let testNote = Note(title: "Тестовая заметка", content: "Это тестовый текст заметки.")
        notes.append(testNote)
        tableView.reloadData()
    }

    private func setupUI() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
    }

    func didEditNote(_ editedNote: Note) {
        if let selectedNoteIndex = selectedNoteIndex {
            notes[selectedNoteIndex] = editedNote
            saveNotesToUserDefaults()
            tableView.reloadData()
        }
    }

    func saveNotesToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "myNotes")
        }
    }

    func loadNotesFromUserDefaults() {
        if let savedNotes = UserDefaults.standard.object(forKey: "myNotes") as? Data {
            let decoder = JSONDecoder()
            if let loadedNotes = try? decoder.decode([Note].self, from: savedNotes) {
                notes = loadedNotes
            }
        }
    }

//MARK: - @objc Methods
    @objc func addNote() {
        let createNoteVC = CreateNoteViewController()
        createNoteVC.delegate = self
        navigationController?.pushViewController(createNoteVC, animated: true)
    }
}

//MARK: - extension NoteViewController
extension NoteViewController: CreateNoteDelegate {
    func didCreateNote(title: String, content: String) {
        let newNote = Note(title: title, content: content)
        notes.append(newNote)
        saveNotesToUserDefaults()
        tableView.reloadData()
    }
}
