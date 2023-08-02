//
//  ViewController.swift
//  applepie2
//
//  Created by DPI Student 041 on 7/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["matcha", "guatemala", "multifarious", "xcaret", "stitch"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons (enable:true)
            updateUI()
        } else {
            enableLetterButtons(enable:false)
        }
        
        
        func updateUI() {
            var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
            let wordWithSpacing = letters.joined(separator: " ")
            correctWordLabel.text = wordWithSpacing
            scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
            treeImageView.image = UIImage(named:"Tree \(currentGame.incorrectMovesRemaining)")
        }
        
         func letterButtonPressed(_ sender: UIButton) {
            sender.isEnabled = false
            let letterString = sender.title(for: .normal)!
            let letter = Character(letterString.lowercased())
            currentGame.playerGuessed(letter: letter)
            updateGameState()
        }
        
        func updateGameState() {
            if currentGame.incorrectMovesRemaining == 0 {
                totalLosses += 1
            } else if currentGame.word == currentGame.formattedWord {
                totalWins += 1
            } else {
                updateUI()
            }
        }
        
        func enableLetterButtons(enable: Bool) {
            for button in letterButtons {
                button.isEnabled = enable
            }
        }
    }
}
