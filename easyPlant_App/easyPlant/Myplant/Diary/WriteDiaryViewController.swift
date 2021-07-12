//
//  WriteDiaryViewController.swift
//  easyPlant
//
//  Created by 현수빈 on 2021/05/23.
//

import UIKit
import FirebaseStorage
import Firebase

//var storage : Storage = FirebaseStorage.Storage.storage()

class WriteDiaryViewController: UIViewController {
    
    var userplant: UserPlant?
    var editDiary : Diary?
    
    var isEdit: Bool = false
    var imageDate : String = ""
    var image : UIImage?
    var dateString:String = ""
    var diarytitle : String = ""
    var diarycontent : String = ""


    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    @IBOutlet weak var contentTextField: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func checkTextWrite(_ sender: UITextField) {
        
//        sender.resignFirstResponder()
        
        //새로 만들기였다면
        
        if titleTextField.text != "", contentTextField.text != "" {
            saveBarButton.isEnabled = true
                
        }
        else {
            saveBarButton.isEnabled = false
        }
        
        
    }
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //편집중이었다면
        if (isEdit == true){
            print("edit")
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == userplant?.name){
                    for j in 0...userPlants[i].diarylist.count-1 {
                        if(userPlants[i].diarylist[j].date == editDiary?.date){
                            
                            
                            print("find userplant index")
                            if let image = imageView.image, let title = userplant?.name {
                                deleteDiaryImage(title: "\(title)-\((editDiary!.title))-\(editDiary!.date)")
                                
                                editDiary?.title = titleTextField.text!
                                print("edit save diary")
                                
                                uploadDiaryImage(img: image, title: "\(title)-\(editDiary!.title)-\(editDiary!.date)")
                                
                                let tmpDate = editDiary!.date
                                let tmpTitle = editDiary!.title
                                editDiary?.picture =  "\(title)-\(tmpTitle)-\(tmpDate)"
                                
                                
                            }
                         
                            editDiary?.story = contentTextField.text!
                            
                            userPlants[i].diarylist[j] = editDiary!
                            print("unwindto edit DiarySegue")
                            
                            
                            //수정하고 저장하기
                            saveUserInfo(user: myUser)
                            saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                            performSegue(withIdentifier: "unwindToEditDiarySegue", sender: self)
                            return
                            
                        }
                    }
                    
                    
                }
            
            }
        }
        
        //새로 만들기 였다면
        else{
            
            diarytitle = titleTextField.text!
            diarycontent = contentTextField.text!
          
           
            for i in 0...(userPlants.count-1) {
                if(userPlants[i].name == userplant?.name){
                //add
                    userPlants[i].diarylist.append(Diary(title: diarytitle, date: imageDate, story: diarycontent, picture: "\(userplant!.name)-\(diarytitle)-\(imageDate)"))
                    print("backTomyplant")
                    
                    print(imageDate)
                    if let image = imageView.image, let title = userplant?.name {
                        uploadDiaryImage(img: image, title: "\(title)-\(diarytitle)-\(imageDate)")
                    }
                
                    
                    //수정하고 저장하기
                    saveUserInfo(user: myUser)
                    saveNewUserPlant(plantsList: userPlants , archiveURL: archiveURL)
                    performSegue(withIdentifier: "backToMyPlant", sender: self)
                
                
                }
            }
                
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToEditDiarySegue"{
            if let detailVC = segue.destination as? MyDiaryViewController{
                detailVC.myplant = userplant
                detailVC.diary = editDiary
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.backgroundColor = UIColor(cgColor: CGColor(red: 174/255, green: 213/255, blue: 129/255, alpha: 1))
   
        
        if let image = image, let _ = userplant{
            imageView.image = image
            
            
        }
   

        saveBarButton.isEnabled = false
        
        let _:Date = Date()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

       //dateString = dateFormatter.string(from: date)
        //dateLabel.text = dateString
        
       // uploadimage(img: image)
        
        if editDiary != nil {
            titleTextField.text =  editDiary?.title
            contentTextField.text = editDiary?.story
            imageView.image = UIImage(named: editDiary!.picture)
        }

        // Do any additional setup after loading the view.
        
        if(isEdit == true){
            saveBarButton.isEnabled = true
            imageView.image = image

        }
        
        
        contentView.layer.zPosition = 100
        imageView.layer.zPosition = 99
        stackView.layer.cornerRadius = 20
        contentView.layer.cornerRadius = 30
        
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    


}
