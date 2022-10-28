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
            
            //increasing the positon of the box to insert the text
            positionNumber = (positionNumber < 30 ? positionNumber + 1 : positionNumber)
          
            //enabing the submit button after reaching a particular spot in this case the last box
            submitBTN.isEnabled = (positionNumber%5 == 0)
            
        }
       
    }
    
    //when pressing the submit button
    func submit()
    {
        submitBTN.isEnabled = false
        backBTN.isEnabled = false
        if(positionNumber > 28)
        {
            startGame()
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
    

}

