//
//  JoinViewController.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/07/10.
//

import UIKit
import Firebase

class JoinViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var pwField: UITextField!
    @IBOutlet weak var pwCheckField: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        joinBtn.layer.cornerRadius = joinBtn.frame.height / 5
        
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
        
        nameField.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: nameField.frame.size.height-1, width: nameField.frame.width, height: 1)
        border3.backgroundColor = UIColor.lightGray.cgColor
        nameField.layer.addSublayer((border3))
        
        pwCheckField.borderStyle = .none
        let border4 = CALayer()
        border4.frame = CGRect(x: 0, y: pwCheckField.frame.size.height-1, width: pwCheckField.frame.width, height: 1)
        border4.backgroundColor = UIColor.lightGray.cgColor
        pwCheckField.layer.addSublayer((border4))
        // Do any additional setup after loading the view.
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
