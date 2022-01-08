//
//  NoteController.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 1/6/22.
//

import Foundation
import CloudKit

class NoteController{
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    // MARK: - Singleton
    static let sharedInstance = NoteController()
    
    // MARK: - Properties
    var notes: [Note] = []
    
    // MARK: - CRUD Functions
    
    func createNote(with title: String, body: String, date: String, completion: @escaping (Result<String, NoteError>) -> Void) {
        
        let newNote = Note(title: title, body: body, timeStamp: date)
        
        let ckRecord = CKRecord(note: newNote)
        
        privateDB.save(ckRecord) { record, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return(completion(.failure(.ckError(error))))
            }
            guard let record = record,
                  let savedNote = Note(ckRecord: record) else { return completion(.failure(.couldNotUnwrap))}
            
            self.notes.append(savedNote)
            completion(.success("Successfully created a note with id: \(savedNote.recordID.recordName)"))
        }
    }
    
    func update(note: Note, completion: @escaping (Result<String, NoteError>) -> Void) {
        
        let record = CKRecord(note: note)
        
        let modOp = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        
        modOp.savePolicy = .changedKeys
        modOp.qualityOfService = .userInteractive
        
        modOp.modifyRecordsCompletionBlock = { records, _, error in
            if let error = error {
                print("***Error*** in Function: \(#function)\n\nError: \(error)\n\nDescription: \(error.localizedDescription)")
                return completion(.failure(.ckError(error)))
            }
            
            guard let record = records?.first,
                  let updatedYak = Note(ckRecord: record) else { return completion(.failure(.couldNotUnwrap)) }
            
            return completion(.success("successfully updated yak with id: \(updatedYak.recordID.recordName)"))
        }
        
        privateDB.add(modOp)
    }

    
    
    /**
     Save the Entry object to CloudKit
     
     - Parameters:
     - entry: Note object created in our createNote function
     - completion: Escaping completion block for the method
     - result: results returned in the completion block, an optional Note object or a specifc NoteError used for debugging.
     */
    func save(note: Note, completion: @escaping (_ result: Result< Note?, NoteError>) -> Void) {
        /// Initialize a CKRecord from the Entry object passed in from our parameters
        let entryRecord = CKRecord(note: note)
        /// call the save method from the privateDatabase
        privateDB.save(entryRecord) { (record, error) in
            /// handle the optional error
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
                return
            }
            /// Unwrap the CKRecord that was saved
            guard let record = record,
                  /// re-create the same Entry object from that record that we know was successfully saved
                  let savedEntry = Note(ckRecord: record)
            else { completion(.failure(.couldNotUnwrap)); return }
            print("new Entry: \(note.recordID) saved successfully")
            /// add the Entry to our local Source of Truth
            self.notes.insert(savedEntry, at: 0)
            /// complete successfully with newly saved Entry object
            completion(.success(savedEntry))
        }
    }
    
    /**
     Fetches all Note objects stored in the CKContainer's privateDataBase
     
     - Parameters:
     - completion: Escaping completion block for the method
     - result: results returned in the completion block, an optional array of Note objects or a specifc EntryError used for debugging.
     */
    func fetchNotesWith(completion: @escaping (_ result: Result<[Note]?, NoteError>) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: NoteStrings.recordTypeKey, predicate: predicate)
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.ckError(error)))
            }
            guard let records = records else { completion(.failure(.couldNotUnwrap)); return }
            print("Successfully fetched all Entries")
            let notes = records.compactMap({ Note(ckRecord: $0) })
            self.notes = notes
            completion(.success(notes))
        }
    }
    
    func delete(_ note: Note, completion: @escaping (Result<Bool, NoteError>) -> Void) {
        
        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [note.recordID])
        
        operation.savePolicy = .changedKeys
        operation.qualityOfService = .userInteractive
        operation.modifyRecordsCompletionBlock = {(records, recordIDs, error) in
            if let error = error {
                return completion(.failure(.ckError(error)))
            }
            print("Records: \(records?.count ?? 99)")
            print("RecordIDs: \(recordIDs?.count ?? 99)")
            
            if records?.count == 0 {
                print("Record: \(note.recordID) was successfully deleted from CloudKit")
                completion(.success(true))
            } else {
                return completion(.failure(.unexpectRecordsFound))
            }
        }
        privateDB.add(operation)
    }
    
}
//        let operation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: [note.recordID])
//
//        operation.savePolicy = .changedKeys
//        operation.qualityOfService = .userInteractive
//        operation.modifyRecordsCompletionBlock = {(records, recordIDs, error) in
//            if let error = error {
//                return completion(.failure(.ckError(error)))
//            }
//            print("Records: \(records?.count ?? 99)")
//            print("RecordIDs: \(recordIDs?.count ?? 99)")
//
//            if records?.count == 0 {
//                print("Record was successfully deleted from CloudKit")
//                completion(.success(true))
//            } else {
//                return completion(.failure(.unexpectRecordsFound))
//            }
//        }
//        privateDB.add(operation)




