//
//  NoteDetailViewController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 1/6/22.
//

import UIKit

class NoteDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteBodyTextView: UITextView!
    
    // MARK: - Propeties
    var note: Note?{
        didSet{
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let note = note{
            guard let title = noteTitleTextField.text, !title.isEmpty,
                  let body = noteBodyTextView.text, !body.isEmpty else { return }
            note.noteTitle = title
            note.noteBody = body
            NoteController.sharedInstance.update(note: note) { (result) in
                DispatchQueue.main.async {
                    switch result{
                    case .success(let message):
                        print(message)
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        } else {
            guard let title = noteTitleTextField.text, !title.isEmpty,
                  let body = noteBodyTextView.text, !body.isEmpty else { return }
            
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let newDate = dateFormatter.string(from: date)
            NoteController.sharedInstance.createNote(with: title, body: body, date: newDate ) { result in
                DispatchQueue.main.async {
                    switch result{
                    case .success(_):
                        self.navigationController?.popViewController(animated: true)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    func updateView(){
        guard let note = note else { return }
        noteTitleTextField.text = note.noteTitle
        noteBodyTextView.text = note.noteBody
    }
}// End of class
