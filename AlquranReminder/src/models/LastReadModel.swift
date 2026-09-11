//
//  Item.swift
//  AlquranReminder
//
//  Created by Hamam Nasrodin on 30/08/2026.
//

import Foundation
import SwiftData

@Model
final class LastReadModel {
    var surahName: String
    var surahNumber: Int
    var verseNumber: Int

    init(surahName: String, surahNumber: Int, verseNumber: Int) {
        self.surahName = surahName
        self.surahNumber = surahNumber
        self.verseNumber = verseNumber
    }
}
