//
//  ViewController.swift
//  Wordle
//
//  Created by Ajay Mandani on 2022-10-26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelViewCollection: [UIView]!
    
    @IBOutlet var labels: [UILabel]!
    
    @IBOutlet weak var backBTN: UIButton!
    
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var submitBTN: UIButton!
    @IBOutlet var buttonViewCollection: [UIView]!
    //default starting postion
    var positionNumber = 0;
    
    //variable for storing current answer by user
    var currentAnswer = ""
    
    //variable for storing correct answer
    var correctAnswer = "FLOOR"
    
    var storeBOXGuess = [0,0,0,0,0] // 0 means it's not in the answer, 1 means it's present but not in correct positon and 2 means its present and in correct possition
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for labelView in labelViewCollection{
            labelView.layer.cornerRadius = 5;
        }
        
        for btnView in buttonViewCollection{
            btnView.layer.cornerRadius = 4;
        }
        backBtnView.layer.cornerRadius = 4;
        startGame()
    }
    
    func startGame()
    {
        currentAnswer = ""
        for labelGame in labels{
            labelGame.text = ""
        }
        backBTN.isEnabled = false
        submitBTN.isEnabled = false
        positionNumber = 0
    }

    //when pressing the back button
    func back(sender:UIButton)
    {
        positionNumber -= 1
        
        //dissabling the back button at the start box
        backBTN.isEnabled = !(positionNumber%5 == 0)
        
        labels[positionNumber].text  = ""
        currentAnswer.removeLast()
        submitBTN.isEnabled = false
    }
    
    //when pressing the add button
    func add(sender:UIButton)
    {
        if(!submitBTN.isEnabled)
        {
            //not letting more than 29 characters to enter in the box
            if(positionNumber == 30)
            {
                return
            }
            
            //whenever we add it's expected we can go back
            backBTN.isEnabled = true
            
            labels[positionNumber].text  = sender.titleLabel?.text
            currentAnswer += sender.titleLabel?.text ?? ""
            //increasing the positon of the box to insert the text
            positionNumber = (positionNumber < 30 ? positionNumber + 1 : positionNumber)
          
            //enabing the submit button after reaching a particular spot in this case the last box
            submitBTN.isEnabled = (positionNumber%5 == 0)
            
        }
       
    }
    
    func colorCodeWords()
    {
        var startIndex = positionNumber-5
        var guessCounterIndex = 0
        while startIndex <= positionNumber-1{
            print(startIndex)
            labels[startIndex].textColor = .white
            if(storeBOXGuess[guessCounterIndex] == 0)
            {
                labelViewCollection[startIndex].backgroundColor = UIColor(red: 69/255, green: 73/255, blue: 71/255, alpha: 1)
            }else if(storeBOXGuess[guessCounterIndex] == 1)
            {
                labelViewCollection[startIndex].backgroundColor = UIColor(red: 219/255, green: 127/255, blue: 33/255, alpha: 1)
            }else{
                labelViewCollection[startIndex].backgroundColor = UIColor(red: 60/255, green: 158/255, blue: 182/255, alpha: 1)
            }
            startIndex += 1
            guessCounterIndex += 1
        }
    }
    //when pressing the submit button
    func submit()
    {
        if(checkIFWordExist(userWord: currentAnswer.lowercased()))
        {
            
            
            submitBTN.isEnabled = false
            backBTN.isEnabled = false
            print(currentAnswer)
            check()
            currentAnswer = ""
            if(positionNumber > 28)
            {
                alertUser(title: "game is over", message: "Press Ok to restart the game")

                startGame()
            }
        }else{
            alertUser(title: "word is not known", message: "Please check your word!!!")
        }
        
    }
    
    @IBAction func keysPressed(_ sender: UIButton) {
            if(sender == backBTN)
            {
                back(sender: sender)
                return
            }
        
            if(sender == submitBTN)
            {
                submit()
                return
            }
        
            add(sender: sender)
    }
    
    //algorithm for the app (checking if the text exists or not)
    func alertUser(title:String,message:String)
    {
        let UIAlert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)

        UIAlert.addAction(action)
        self.show(UIAlert, sender: nil)
       
    }

    func check()
    {
        storeBOXGuess = [0,0,0,0,0]
        if(currentAnswer == correctAnswer)
        {
            alertUser(title: "CONGRATULATIONS!!", message: "WOULD YOU LIKE TO PLAY NEXT ROUND")
            startGame()
        }else
        {
            for i in 0..<correctAnswer.count
            {
                let correctChar = (correctAnswer[correctAnswer.index(correctAnswer.startIndex, offsetBy: i)])
                let belowChar = (currentAnswer[currentAnswer.index(currentAnswer.startIndex, offsetBy: i)])
                
                //FIRST COMPARING IT WITH DOWN PART IF IT MATCHES THEN CONTINUE WITH THE NEXT CHARACTER
                if(correctChar == belowChar)
                {
                    storeBOXGuess[i] = 2
                    continue
                }
                
                for j in 0..<currentAnswer.count
                {
                    let currentChar = currentAnswer[currentAnswer.index(currentAnswer.startIndex, offsetBy: j)]
                    
                    //CHECKING WITH OTHER CHARACTER POSTION IF FOUND MARK IT WITH 1
                    if(correctChar == currentChar && storeBOXGuess[j] == 0)
                    {
                        storeBOXGuess[j] = 1
                        break
                    }
                }
            }
            print(storeBOXGuess)
            colorCodeWords()
        }
    }
    
    func checkIFWordExist(userWord:String) -> Bool
    {
        let textcheck = UITextChecker()
        let rangeCount = NSRange(location: 0, length: userWord.utf16.count)
        let checkwrounword = textcheck.rangeOfMisspelledWord(in: userWord, range: rangeCount, startingAt: 0, wrap: false, language: "en")
        return checkwrounword.location == NSNotFound
    }


}
