//
//  User.swift
//  MVVM_Architecture
//
//  Created by G Yacobu on 08/08/25.
//

import Foundation
import SwiftData

@Model
class Note {
    var title: String
    var content: String
    var date: Date
    
    init(title: String, content: String, date: Date = Date()) {
        self.title = title
        self.content = content
        self.date = date
    }
}
