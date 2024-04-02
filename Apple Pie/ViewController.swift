//
//  ViewController.swift
//  Apple Pie
//
//  Created by Assem Seidkarim on 02.04.2024.
//

import UIKit


    
var listOfWords = ["cat", "crocodile", "dog", "tiger","elephant", "lion","horse"]
let incorrectMovesAllowed = 7

class ViewController: UIViewController {
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totallosses = 0 {
        didSet {
            newRound()
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func letterButtonsPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totallosses += 1
        } else if !currentGame.formattedWord.contains("_") {
            totalWins += 1
        } else {
            updateUI()
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
       
        
    }
    
    var currentGame: Game!
    
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game (word: newWord,incorrectMovesRemaining: incorrectMovesAllowed,guessedLetters: [])
            enableLetterButtons (true)
            updateUI()
        } else {
            enableLetterButtons (false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append (String(letter))
            }
        let wordWithSpacing = letters.joined (separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins),Losses: \(totallosses)"
        treeImageView.image = UIImage(named:"Tree \(currentGame.incorrectMovesRemaining)")
        
    }

    
   
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    

}

