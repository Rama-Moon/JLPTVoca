//
//  UserInfo.swift
//  JLPTVoca
//
//  Created by Rama on 8/27/25.
//

import Foundation
import SwiftData

@Model
final class UserSettings {
   var targetExamLevel: Int
   var targetExamDate: Date
   var dailyNewWordGoal: Int
   
   init(
       targetExamLevel: Int,
       targetExamDate: Date,
       dailyNewWordGoal: Int,
       activeLevel: Int
   ) {
       self.targetExamLevel = targetExamLevel
       self.targetExamDate = targetExamDate
       self.dailyNewWordGoal = dailyNewWordGoal
   }
}
