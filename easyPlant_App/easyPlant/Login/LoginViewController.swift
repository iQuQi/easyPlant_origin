//
//  LoginViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/10.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var findBtn: UIButton!
    @IBOutlet weak var joinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = loginBtn.frame.height / 5
        
        IDField.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: IDField.frame.size.height-1, width: IDField.frame.width, height: 1)
        IDField.layer.addSublayer((border))
        border.backgroundColor = UIColor.lightGray.cgColor
        
        pwField.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: pwField.frame.size.height-1, width: pwField.frame.width, height: 1)
        border2.backgroundColor = UIColor.lightGray.cgColor
        pwField.layer.addSublayer((border2))
    }
    
    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    
    @IBAction func findBtnTapped(_ sender: Any) {
    }
    @IBAction func joinBtnTapped(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
