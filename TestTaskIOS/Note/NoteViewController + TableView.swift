//
//  NoteViewController + TableView.swift
//  TestTaskIOS
//
//  Created by Sergo on 27.01.2024.
//

import UIKit

//MARK: - UITableViewDataSource
extension NoteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.contentLabel.text = note.content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNoteIndex = indexPath.row
        let createNoteVC = CreateNoteViewController()
        createNoteVC.delegate = self
        if let selectedNoteIndex = selectedNoteIndex {
            createNoteVC.noteToEdit = notes[selectedNoteIndex]
        }
        navigationController?.pushViewController(createNoteVC, animated: true)
    }
}

//MARK: - UITableViewDelegate
extension NoteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            if editingStyle == .delete {
                self.showDeleteAlert(indexPath: indexPath)
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return screenHeight / 12
    }
}
