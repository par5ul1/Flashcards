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
    @IBOutlet weak var card: UIView!
    
    var correctAnswerButton: UIButton!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        card.alpha = 0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        answerButtonOne.alpha = 0
        answerButtonOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        answerButtonTwo.alpha = 0
        answerButtonTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        answerButtonThree.alpha = 0
        answerButtonThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        answerButtonFour.alpha = 0
        answerButtonFour.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, animations: {
            self.card.alpha = 1
            self.card.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.answerButtonOne.alpha = 1
            self.answerButtonOne.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.answerButtonTwo.alpha = 1
            self.answerButtonTwo.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.answerButtonThree.alpha = 1
            self.answerButtonThree.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
            self.answerButtonFour.alpha = 1
            self.answerButtonFour.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        creationController.flashcardController = self
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = flashcards[currentIndex].answer
            creationController.initialAnswer1 = flashcards[currentIndex].answer1
            creationController.initialAnswer2 = flashcards[currentIndex].answer2
            creationController.initialAnswer3 = flashcards[currentIndex].answer3
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
        
        let buttons = [answerButtonOne, answerButtonTwo, answerButtonThree, answerButtonFour].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.answer1, currentFlashcard.answer2, currentFlashcard.answer3].shuffled()
        
        for (button, answer) in zip(buttons, answers) {
            button?.setTitle(answer, for: .normal)
            button?.isEnabled = true
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
        
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
        flipFlashcard()
    }
    
    func flipFlashcard() {
        if questionLabel.isHidden {
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromLeft, animations: {
                self.questionLabel.isHidden = false
            })
        } else {
            UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.questionLabel.isHidden = true
            })
        }
    }
    
    func animateCardInNext() {
        card.transform = CGAffineTransform.identity.translatedBy(x: 350, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    func animateCardOutNext() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -350, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardInNext()
        })
    }
    
    func animateCardOutPrev() {
        card.transform = CGAffineTransform.identity.translatedBy(x: -350, y: 0.0)
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    func animateCardInPrev() {
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: 350, y: 0.0)
        }, completion: { finished in
            self.updateLabels()
            self.animateCardOutPrev()
        })
    }
    
    @IBAction func didTapButtonOne(_ sender: Any) {
        if answerButtonOne == correctAnswerButton {
            flipFlashcard()
        } else {
            answerButtonOne.isEnabled = false
        }
    }
    
    @IBAction func didTapButtonTwo(_ sender: Any) {
        if answerButtonTwo == correctAnswerButton {
            flipFlashcard()
        } else {
            answerButtonTwo.isEnabled = false
        }
    }
    
    @IBAction func didTapButtonThree(_ sender: Any) {
        if answerButtonThree == correctAnswerButton {
            flipFlashcard()
        } else {
            answerButtonThree.isEnabled = false
        }
    }

    @IBAction func didTapButtonFour(_ sender: Any) {
        if answerButtonFour == correctAnswerButton {
            flipFlashcard()
        } else {
            answerButtonFour.isEnabled = false
        }
    }
    
    @IBAction func didTapPrevButton(_ sender: Any) {
        currentIndex -= 1
        updateBrowseButtons()
        animateCardInPrev()
    }

    @IBAction func didTapNextButton(_ sender: Any) {
        currentIndex -= -1
        updateBrowseButtons()
        animateCardOutNext()
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

