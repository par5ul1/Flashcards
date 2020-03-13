//
//  ViewController.swift
//  Flashcards
//
//  Created by Parsa Rahimi on 2/15/20.
//  Copyright © 2020 Parsa Rahimi. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var answer1: String
    var answer2: String
    var answer3: String
}

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        let cardCornerRadius : CGFloat = 20.0
        let buttonBorderWidth : CGFloat = 3.0
        let buttonBorderColor : CGColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0.3176470588, alpha: 1)
        let buttonCornerRadius : CGFloat = 10.0
        super.viewDidLoad()
        
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = cardCornerRadius
        answerLabel.clipsToBounds = true
        answerLabel.layer.cornerRadius = cardCornerRadius
        
        card.layer.cornerRadius = cardCornerRadius
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        
        answerButtonOne.layer.borderWidth = buttonBorderWidth
        answerButtonOne.layer.borderColor = buttonBorderColor
        answerButtonOne.layer.cornerRadius = buttonCornerRadius
        answerButtonTwo.layer.borderWidth = buttonBorderWidth
        answerButtonTwo.layer.borderColor = buttonBorderColor
        answerButtonTwo.layer.cornerRadius = buttonCornerRadius
        answerButtonThree.layer.borderWidth = buttonBorderWidth
        answerButtonThree.layer.borderColor = buttonBorderColor
        answerButtonThree.layer.cornerRadius = buttonCornerRadius
        answerButtonFour.layer.borderWidth = buttonBorderWidth
        answerButtonFour.layer.borderColor = buttonBorderColor
        answerButtonFour.layer.cornerRadius = buttonCornerRadius
        
        readSavedFlashcards()
        
        deleteButton.isEnabled = flashcards.count > 1
        print(flashcards.count)
        if flashcards.count == 0 {
            updateFlashcard(question: "What operating system is run on iPhones?", answer: "iOS", answer1: "Android", answer2: "Linux", answer3: "Windows", isExisting: false)
        } else {
            updateLabels()
            updateBrowseButtons()
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
            creationController.initialAnswer1 = answerButtonOne.title(for: .normal)
            creationController.initialAnswer2 = answerButtonTwo.title(for: .normal)
            creationController.initialAnswer3 = answerButtonThree.title(for: .normal)
        }
    }
    
    func updateFlashcard(question: String, answer: String, answer1: String, answer2: String, answer3: String, isExisting: Bool) {
        let flashcard = Flashcard(question: question, answer: answer, answer1: answer1, answer2: answer2, answer3: answer3)
        
        if isExisting {
            flashcards[currentIndex] = flashcard
        } else {
            flashcards.append(flashcard)
            print("New Flashcard Added!")
            print("We now have \(flashcards.count) Flashcards.")
            
            currentIndex = flashcards.count - 1
            print("The current index is \(currentIndex)")
            
            deleteButton.isEnabled = true
        }
        
        updateBrowseButtons()
        updateLabels()
        
        saveAllFlashcardsToDisk()
    }
    
    func updateBrowseButtons() {
        nextButton.isEnabled = !(currentIndex == flashcards.count - 1)
        prevButton.isEnabled = !(currentIndex == 0)
    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
        
        answerButtonOne.setTitle(currentFlashcard.answer1, for: .normal)
        answerButtonOne.isHidden = false
        answerButtonTwo.setTitle(currentFlashcard.answer2, for: .normal)
        answerButtonTwo.isHidden = false
        answerButtonThree.setTitle(currentFlashcard.answer3, for: .normal)
        answerButtonThree.isHidden = false
        answerButtonFour.setTitle(currentFlashcard.answer, for: .normal)
        answerButtonFour.isHidden = false
        
    }
    
    func saveAllFlashcardsToDisk() {
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question": card.question, "answer": card.answer, "answer1": card.answer1, "answer2": card.answer2, "answer3": card.answer3]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards Saved to Disk!")
    }
    
    func readSavedFlashcards() {
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { (dictionary) -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, answer1: dictionary["answer1"]!, answer2: dictionary["answer2"]!, answer3: dictionary["answer3"]!)
            }
            
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    // Keeping below for added functionality, in case one wants to cheat
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        // Who doesn't love a little bit of ternary?
        questionLabel.isHidden = questionLabel.isHidden ? false : true
    }
    
    @IBAction func didTapButtonOne(_ sender: Any) {
        answerButtonOne.isHidden = true
    }
    
    @IBAction func didTapButtonTwo(_ sender: Any) {
        answerButtonTwo.isHidden = true
    }
    
    @IBAction func didTapButtonThree(_ sender: Any) {
        answerButtonThree.isHidden = true
    }

    @IBAction func didTapButtonFour(_ sender: Any) {
        questionLabel.isHidden = true
    }
    
    @IBAction func didTapPrevButton(_ sender: Any) {
        currentIndex -= 1
        updateLabels()
        updateBrowseButtons()
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        currentIndex -= -1
        updateLabels()
        updateBrowseButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you wish to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.deleteFlashcard()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    func deleteFlashcard() {
        flashcards.remove(at: currentIndex)
        
        currentIndex = currentIndex > flashcards.count - 1 ? flashcards.count - 1 : currentIndex
        deleteButton.isEnabled = currentIndex > 0
        updateLabels()
        updateBrowseButtons()
        saveAllFlashcardsToDisk()
    }
    
}

