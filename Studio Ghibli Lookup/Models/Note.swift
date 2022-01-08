//
//  File.swift
//  Studio Ghibli Lookup
//
//  Created by Andrew Saeyang on 1/6/22.
//

import Foundation
import CloudKit

enum NoteStrings{
    static let recordTypeKey = "Note"
    fileprivate static let noteTitleKey = "title"
    fileprivate static let noteBodyKey = "body"
    fileprivate static let timeStampKey = "timeStamp"
}

class Note{
    
    var noteTitle: String
    var noteBody: String
    let timeStamp: String
    let recordID: CKRecord.ID
    
    init(title: String, body: String, timeStamp: String, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)){
        self.noteTitle = title
        self.noteBody = body
        self.timeStamp = timeStamp
        self.recordID = recordID
    }
    
    
}// End of class
extension CKRecord{
    ///Turning a note into a record
    convenience init(note: Note){
        self.init(recordType: NoteStrings.recordTypeKey, recordID: note.recordID)
        
        self.setValuesForKeys([
            NoteStrings.noteTitleKey : note.noteTitle,
            NoteStrings.noteBodyKey : note.noteBody,
            NoteStrings.timeStampKey : note.timeStamp
        ])
    }
}// End of Extension


extension Note: Equatable{
    
    convenience init?(ckRecord: CKRecord){
        guard let title = ckRecord[NoteStrings.noteTitleKey] as? String,
              let body = ckRecord[NoteStrings.noteBodyKey] as? String,
              let timeStamp = ckRecord[NoteStrings.timeStampKey] as? String else { return nil}
        
        self.init(title: title, body: body, timeStamp: timeStamp, recordID: ckRecord.recordID)
        
    }
    
    static func == (lhs: Note, rhs: Note ) -> Bool{
        
        return lhs.recordID == rhs.recordID
        
    }
    
}// End of Extension
