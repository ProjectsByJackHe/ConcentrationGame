//
//  ViewController.swift
//  Concentration
//
//  Created by Jack He on 6/9/19.
//  Copyright © 2019 Stanford University: Jack He. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //*important:
    lazy var game = Concentration(numberOfPairsOfCards: (arrOfButtons.count + 1)/2)
    //*important
    
    var flipCount = 0 {
        didSet {
            //observes changes in flipcount and sets the label accordingly.
            scoreBoard.text = "Flips: \(flipCount)"
            //scoreBoard.font = UIFont(name: "Helvetica", size: 40)
        }
    }
    @IBOutlet weak var scoreBoard: UILabel!
    
    @IBOutlet var arrOfButtons: [UIButton]!
    
    var count = 0
    
    @IBAction func newGame(_ sender: UIButton) {
        //make all the cards isMatched = false
        for index in arrOfButtons.indices {
            game.cards[index].isMatched = false
            game.cards[index].isFaceUp = false
        }
        game.cards = game.cards.shuffled()
        //turn all the cards face down. isFaceUp = false
        updateViewFromModel()
        flipCount = 0
        scoreBoard.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        count = 0
    }

    @IBAction func touchCard(_ sender: UIButton) {
        //flipCount += 1
    if let cardNumber = arrOfButtons.lastIndex(of: sender){
        if game.cards[cardNumber].isMatched == false, game.cards[cardNumber].isFaceUp == false {
            flipCount += 1
        }
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
    }
        else {
            scoreBoard.text = "This card does not exist in the database."
            scoreBoard.font = UIFont (name: "Marker Felt", size: 15)
        }
        for j in arrOfButtons.indices {
            if game.cards[j].isMatched {
                count += 1
            }
        }
        //print(count)
            if count == arrOfButtons.count{
                scoreBoard.text = "You Win!" + " (\(flipCount) flips)"
                scoreBoard.textColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
            }
            else {
                count = 0
            }
    }
    
    func updateViewFromModel() {
        for index in arrOfButtons.indices {
            let button = arrOfButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5849599242, blue: 0.3988677263, alpha: 0) : #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
            }
        }
    }
    
    var emojis = ["🉑","🈶","🈸","🈺","🈚️","🉐","㊙️","㊗️","🈴","🈵","🈲"]
    
    var dictOfEmojis = [Int:String]()
    
    func emoji(for card:Card) -> String {
        if dictOfEmojis[card.identifier] == nil, emojis.count > 0 {
            dictOfEmojis[card.identifier] = emojis.remove(at: emojis.count.randomInt)
        }
        return dictOfEmojis[card.identifier] ?? "?"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}
extension Int {
    var randomInt:Int {
        if self > 0 {
        return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
