//
//  ViewController.swift
//  Nim-MultiPeerConnectivity
//
//  Created by Jian Ma on 1/9/20.
//  Copyright © 2020 Jian Ma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nametextField: UITextField!
    var playerName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        playerName = self.nametextField.text ?? "no name"
    }
    
    @IBAction func addOneButtonTapped(_ sender: UIButton) {
    }
    @IBAction func addTwoButtonTapped(_ sender: UIButton) {
    }
    @IBAction func addThreeButtonTapped(_ sender: UIButton) {
    }
    
}

