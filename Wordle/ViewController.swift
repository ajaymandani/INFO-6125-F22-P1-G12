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
        backBTN.isEnabled = false
        submitBTN.isEnabled = false
    }

    
    @IBAction func keysPressed(_ sender: UIButton) {
        
        print(sender.titleLabel?.text)
    }
    

}

