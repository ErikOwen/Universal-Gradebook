//
//  GradebookLoader.swift
//  Gradebook
//
//  Created by Erik Owen on 5/19/15.
//  Copyright (c) 2015 Erik Owen. All rights reserved.
//

import Foundation

class GradebookLoader {
    
    private var _loader: GradebookURLLoader
    
    private var _curSection: Section?
    private var _curEnrollment: Enrollment?
    private var _curAssignment: UserScore?
    
    init() {
        _loader = GradebookURLLoader()
    }
    
    func setCurrentSection(curSection: Section) {
        _curSection = curSection
    }
    
    func getCurrentSection() -> Section {
        return _curSection!
    }
    
    func setCurrentEnrollment(curEnrollment: Enrollment) {
        _curEnrollment = curEnrollment
    }
    
    func getCurrentEnrollment() -> Enrollment {
        return _curEnrollment!
    }
    
    func setCurrentAssignment(curAssignment: UserScore) {
        _curAssignment = curAssignment
    }
    
    func getCurrentAssignment() -> UserScore {
        return _curAssignment!
    }
    
    func loginWithUsername(name: String, password: String, baseURL: String) -> Bool {
        _loader.baseURL = baseURL
        
        if _loader.loginWithUsername(name, andPassword: password) {
            println("Auth worked!")
            return true;
        }
        else {
            println("Auth failed!")
            return false;
        }
    }
    
    func loadSections() -> Sections {
        let data = _loader.loadDataFromPath("?record=sections", error: nil)
        
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        println("Sections: \(str)")
        
        let json = JSON(data: data)
        var tempSections: Sections = Sections();
        
        for (index, sectionJSON) in json["sections"] {
            
            let tempSection = Section()
            
            tempSection.course = sectionJSON["course"].stringValue
            tempSection.dept = sectionJSON["dept"].stringValue
            tempSection.term = sectionJSON["term"].stringValue
            tempSection.termname = sectionJSON["termname"].stringValue
            tempSection.title = sectionJSON["title"].stringValue
            
            tempSections.appendSection(tempSection)
        }
        
        return tempSections
    }
    
    func loadEnrollments() -> Enrollments {
        let enrollmentsUrl: String = "?record=enrollments&term=" + getCurrentSection().term! + "&course=" + getCurrentSection().course!
        
        let data = _loader.loadDataFromPath(enrollmentsUrl, error: nil)
        
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        println("Enrollments: \(str)")
        
        let json = JSON(data: data)
        var tempEnrollments: Enrollments = Enrollments();
        
        for (index, enrollmentJSON) in json["enrollments"] {
            
            let tempEnrollment = Enrollment()
            
            tempEnrollment.first_name = enrollmentJSON["first_name"].stringValue
            tempEnrollment.middle_name = enrollmentJSON["middle_name"].stringValue
            tempEnrollment.last_name = enrollmentJSON["last_name"].stringValue
            tempEnrollment.username = enrollmentJSON["username"].stringValue
            
            tempEnrollments.appendEnrollment(tempEnrollment)
        }
        
        return tempEnrollments
    }
    
    func loadUserScores() -> UserScores {
        let userScoresUrl: String = "?record=userscores&term=" + getCurrentSection().term! + "&course=" + getCurrentSection().course! + "&user=" + getCurrentEnrollment().username!
        
        let data = _loader.loadDataFromPath(userScoresUrl, error: nil)
        
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)
        
        println("UserScores: \(str)")
        
        let json = JSON(data: data)
        var tempUserScores: UserScores = UserScores();
        
        for (index, userScoreJSON) in json["userscores"] {
            
            let tempUserScore = UserScore()
            
            tempUserScore.name = userScoreJSON["name"].stringValue
            tempUserScore.max_points = userScoreJSON["max_points"].intValue
            tempUserScore.scores = Scores()
            
            for scoreJSON in userScoreJSON["scores"].arrayValue {
                var tempScore: Score = Score()
                
                tempScore.displayScore = scoreJSON["display_score"].stringValue
                tempScore.score = scoreJSON["score"].intValue
                tempScore.max_points = userScoreJSON["max_points"].intValue
                
                tempUserScore.scores?.appendScore(tempScore)
            }
            
            tempUserScores.appendUserScore(tempUserScore)
        }
        
        return tempUserScores
    }
    
    func loadScores() -> Scores {
        return _curAssignment!.scores!
    }
}
