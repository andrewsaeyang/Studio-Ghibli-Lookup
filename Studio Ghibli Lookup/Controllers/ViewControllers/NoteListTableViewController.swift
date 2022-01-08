//
//  NoteListTableViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 1/6/22.
//

import UIKit

class NoteListTableViewController: UITableViewController {
    
    // MARK: - Properties
    fileprivate var toNoteDetailVC = "toNoteDetailVC"
    fileprivate var identifier = "noteCell"
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NoteController.sharedInstance.fetchNotesWith { (result) in
            self.updateView()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        updateView()
    }
    
    // MARK: - Helper Methods
    func updateView(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NoteController.sharedInstance.notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        let note = NoteController.sharedInstance.notes[indexPath.row]
        content.text = note.noteTitle
        content.secondaryText = note.timeStamp
        cell.contentConfiguration = content
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let noteToDelete = NoteController.sharedInstance.notes[indexPath.row]
            guard let index = NoteController.sharedInstance.notes.firstIndex(of: noteToDelete) else { return }
            
            NoteController.sharedInstance.delete(noteToDelete) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        NoteController.sharedInstance.notes.remove(at: index)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == toNoteDetailVC {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? NoteDetailViewController else { return }
            
            let noteToSend = NoteController.sharedInstance.notes[indexPath.row]
            destinationVC.note = noteToSend
            
        }
    }
}// End of class
