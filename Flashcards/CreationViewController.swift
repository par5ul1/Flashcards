//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Parsa Rahimi on 2/29/20.
//  Copyright © 2020 Parsa Rahimi. All rights reserved.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardController: ViewController!

    @IBOutlet weak var questionField: UITextField!
    @IBOutlet weak var answerField: UITextField!
    @IBOutlet weak var answer1Field: UITextField!
    @IBOutlet weak var answer2Field: UITextField!
    @IBOutlet weak var answer3Field: UITextField!
    
    var initialQuestion: String?
    var initialAnswer: String?
    var initialAnswer1: String?
    var initialAnswer2: String?
    var initialAnswer3: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionField.text = initialQuestion
        answerField.text = initialAnswer
        
        answer1Field.text = initialAnswer1
        answer2Field.text = initialAnswer2
        answer3Field.text = initialAnswer3
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        let questionText = questionField.text
        let answerText = answerField.text
        let answer1Text = answer1Field.text
        let answer2Text = answer2Field.text
        let answer3Text = answer3Field.text
        if (questionText == nil || questionText!.isEmpty) || (answerText == nil || answerText!.isEmpty) || (answer1Text == nil || answer1Text!.isEmpty) || (answer2Text == nil || answer2Text!.isEmpty) || (answer3Text == nil || answer3Text!.isEmpty) {
            let alert = UIAlertController(title: "Missing Text", message: "You need to enter both a question and an answer.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        } else {
            flashcardController.updateFlashcard(question: questionText!, answer: answerText!, answer1: answer1Text!, answer2: answer2Text!, answer3: answer3Text!)
            dismiss(animated: true)
        }
    }

}
