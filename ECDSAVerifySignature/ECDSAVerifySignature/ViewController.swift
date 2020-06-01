//
//  ViewController.swift
//  ECDSAVerifySignature
//
//  Created by Rajan on 22/05/20.
//  Copyright © 2020 Daily Dozen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var plainTextLbl:UILabel!
    @IBOutlet var publicKeyLbl:UILabel!
    @IBOutlet var signatureLbl:UILabel!
    @IBOutlet var verifyResultLbl:UILabel!
    
    private let publicKey = "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAElfmJXmbbJs0+AYhWpO/AAAbe/EesUEWZ6LSsrXQrbEIDQkSwpxuuzSvXEZ7OD4n3T6/0rQVNHnLYF/We5RgKtQ=="
    private let plainText = "verify digital signature"
    private let signature = "MEUCIQD3zXEh+lcLUiLuw6w/4TTtf8ipndcQGl1hJSx4Qqh8nwIgAbtKa71ZT1HpZZY1Kamj6mgUW1iOZnOXcT0MEQXjIxY="
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicKeyLbl.text = "Public Key: \n \(publicKey)"
        plainTextLbl.text = "Plain Text: \n \(plainText)" 
        signatureLbl.text = "Signature: \n \(signature)"
        verifyResultLbl.text = "Verification Pending"
    }
    
    @IBAction func verifyECDSA(){
        let cryptoManager = ECDSACryptoManager()
        verifyResultLbl.text = cryptoManager.validateECDSA256r1Signature(publicKey: publicKey, plainText: plainText, signature: signature)
    }
}

