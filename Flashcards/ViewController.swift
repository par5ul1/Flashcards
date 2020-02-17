//
//  ViewController.swift
//  Flashcards
//
//  Created by Parsa Rahimi on 2/15/20.
//  Copyright © 2020 Parsa Rahimi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var answerButtonOne: UIButton!
    @IBOutlet weak var answerButtonTwo: UIButton!
    @IBOutlet weak var answerButtonThree: UIButton!
    @IBOutlet weak var answerButtonFour: UIButton!
    
    @IBOutlet weak var card: UIView!
    
    override func viewDidLoad() {
        let cardCornerRadius : CGFloat = 20.0
        let buttonBorderWidth : CGFloat = 3.0
        let buttonBorderColor : CGColor = #colorLiteral(red: 1, green: 0.8549019608, blue: 0.3176470588, alpha: 1)
        let buttonCornerRadius : CGFloat = 10.0
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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


}

