//
//  ModelObjects.swift
//  Gradebook
//
//  Created by Erik Owen on 5/14/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//

import Foundation


class Section {
    var term: String?
    var termname: String?
    var dept: String?
    var course: String?
    var title: String?
}

class Sections {
    private var _sections: [Section] = []
    
    var sections: [Section] {
        get {
            return _sections
        }
    }
    
    func appendSection(section: Section) {
        _sections.append(section);
    }
    
    func removeAllSections() {
        _sections.removeAll(keepCapacity: true);
    }
    
    func getSize() -> Int {
        return _sections.count
    }
    
    func getSectionAtPos(index: Int) -> Section {
        return _sections[index]
    }
}

class Enrollment {
    var first_name: String?
    var middle_name: String?
    var last_name: String?
    var username: String?
    var major: String?
}

class Enrollments {
    private var _enrollments: [Enrollment] = []
    
    var enrollments: [Enrollment] {
        get {
            return _enrollments
        }
    }
    
    func appendEnrollment(enrollment: Enrollment) {
        _enrollments.append(enrollment);
    }
    
    func removeAllEnrollments() {
        _enrollments.removeAll(keepCapacity: true);
    }
    
    func getSize() -> Int {
        return _enrollments.count
    }
    
    func getEnrollmentnAtPos(index: Int) -> Enrollment {
        return _enrollments[index]
    }
}

class UserScore {
    var name: String?
    var max_points: Int?
    var scores: Scores?
}

class UserScores {
    private var _userScores: [UserScore] = []
    
    var userScores: [UserScore] {
        get {
            return _userScores
        }
    }
    
    func appendUserScore(userScore: UserScore) {
        _userScores.append(userScore);
    }
    
    func removeAllEnrollments() {
        _userScores.removeAll(keepCapacity: true);
    }
    
    func getSize() -> Int {
        return _userScores.count
    }
    
    func getUserScoreAtPos(index: Int) -> UserScore {
        return _userScores[index]
    }
}

class Score {
    var score: Int?
    var displayScore: String?
    var max_points: Int?
}

class Scores {
    private var _scores: [Score] = []
    
    var scores: [Score] {
        get {
            return _scores
        }
    }
    
    func appendScore(score: Score) {
        _scores.append(score);
    }
    
    func removeAllEnrollments() {
        _scores.removeAll(keepCapacity: true);
    }
    
    func getSize() -> Int {
        return _scores.count
    }
    
    func getScoreAtPos(index: Int) -> Score {
        return _scores[index]
    }
}
