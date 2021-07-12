//
//  User.swift
//  easyPlant
//
//  Created by 차다윤 on 2021/05/30.
//

import Foundation
import UIKit
import FirebaseStorage
let userInfoURL = documentsDirectory.appendingPathComponent("savingUserInfo.json")

struct User : Codable{
    var level: Level
    var growingDays: Int
    var numPlants: Int
    var userName:String
    var isChangeProfile: Int
    var hapiness: Int //int형으로 바꿨어
    let registeredDate: Date
    
    private enum CodingKeys : String, CodingKey{
        case level, growingDays, numPlants, hapiness, registeredDate,userName,isChangeProfile}
    
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        level = try container.decode(Level.self, forKey: .level)
        growingDays = try container.decode(Int.self, forKey: .growingDays)
        numPlants = try container.decode(Int.self, forKey: .numPlants)
       
        hapiness = try container.decode(Int.self, forKey: .hapiness)
        registeredDate = try container.decode(Date.self, forKey: .registeredDate)
       
        userName = try container.decode(String.self, forKey: .userName)
        isChangeProfile = try container.decode(Int.self, forKey: .isChangeProfile)
        
    }
    
    public func encode(to encoder: Encoder) throws {
        var valueContatiner = encoder.container(keyedBy: CodingKeys.self)
        
        try valueContatiner.encode(self.level,forKey: CodingKeys.level)
        try valueContatiner.encode(self.growingDays,forKey: CodingKeys.growingDays)
        try valueContatiner.encode(self.numPlants,forKey: CodingKeys.numPlants)
      
        try valueContatiner.encode(self.hapiness,forKey: CodingKeys.hapiness)
        try valueContatiner.encode(self.registeredDate,forKey: CodingKeys.registeredDate)
       
        try valueContatiner.encode(self.userName,forKey: CodingKeys.userName)
        try valueContatiner.encode(self.isChangeProfile,forKey: CodingKeys.isChangeProfile)
        
    }
    
    
    init(_ registeredDate: Date) {
        level = levels[0]
        growingDays = 10
        numPlants = 2
        hapiness = 80
        self.registeredDate = registeredDate
        userName = "사용자"
        isChangeProfile = 0
    }
    
    mutating func updateUser() {
        //여기에 사용자이름 업데이트 해주기 - 회원가입시에
        
        
        numPlants = userPlants.count
        growingDays = Calendar.current.dateComponents([.day], from: registeredDate, to: Date()).day!
        
        hapiness = 0
        for plant in userPlants {
            var total_happy = 0
            for happy in plant.happeniess {
                total_happy += happy
            }
            if total_happy != 0 {
                hapiness += total_happy / plant.happeniess.count

            }
            
        }
        
        hapiness /= userPlants.count
        
        for standard in levels {
            if Int(standard.hapiness) <= hapiness && standard.numPlants <= numPlants && standard.growingDays <= growingDays {
                self.level = standard
            }
        }
    }
}

// 사용자가 처음 식물을 등록한 날로 바꿔야 함.



func loadUserInfo(){
    let jsonDecoder = JSONDecoder()
    print("load user info start")
        
        do{
           
            
            let jsonData  = try Data(contentsOf: userInfoURL, options: .mappedIfSafe)
            let decoded = try jsonDecoder.decode(User.self, from: jsonData)

           myUser = decoded
            
            
            
        }
        catch {
            print("에러")
            print(error)
           
        }

    print("load user info finish")
}


func  saveUserInfo(user : User) {

    
    let jsonEncoder = JSONEncoder()

      do{
          let encodeData = try jsonEncoder.encode(user)
     
         print("user info save")
          print(userInfoURL)
        
          do{
              try encodeData.write(to: userInfoURL, options: .noFileProtection)
               
          }
          catch let error as NSError {
              print(error)
          }
          
          
      }
      catch {
          print(error)
      }
    

    print("user info save complete")
}



func downloadProfileImage(imgview:UIImageView){
    print("download profile image")
    let urlString:String = documentsDirectory.absoluteString + "localProfile/profile"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
    
    
    //로컬에 없다면 원격 저장소에서 받아온다
    if let data = NSData(contentsOf: localURL){
        //로컬에 이미지가 존재할 경우 로컬 저장소에서 사용
        print("exist and download fast")
        let image = UIImage(data: data as Data)
        imgview.image = image
        
    }
    else {
        let localURL = documentsDirectory.appendingPathComponent("localProfile/profile")
        print("download to local start")
        // Create a reference to the file you want to download
        let filePath = "/profile/profile"
        let imgRef = storageRef.child(filePath)
        

        // print local filesystem URL
        print(localURL)

        // Download to the local filesystem
        imgRef.write(toFile: localURL) { url, error in
          if let error = error {
            print("download to local error : \(error)")

          } else {
            print("download to local success!!")
            print(url)
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            imgview.image = image
          }
          
        }
        print("download to local finish")

        
    }
    
    
    
 }
 
 
func uploadProfileImage(img :UIImage){
    
     
     var data = Data()
    data = img.jpegData(compressionQuality: 0.7)!
     let filePath = "/profile/profile"
     let metaData = StorageMetadata()
     metaData.contentType = "image/png"
     storageRef.child(filePath).putData(data,metadata: metaData){
             (metaData,error) in if let error = error{
             print(error.localizedDescription)
             return
                 
         }
         else{
             print("성공")
         }
     }

 }

func deleteProfileImage(){
    // Create a reference to the file to delete
    let desertRef = storageRef.child("/profile/profile")

    // Delete the file
    desertRef.delete { error in
      if let error = error {
            print("delete user plant error + \(error)")
      } else {
        print("delete user plant success")
      }
    }
    
    // 1. 인스턴스 생성 - 동일
    let fileManager = FileManager.default
    let urlString:String = documentsDirectory.absoluteString + "localProfile/profile"
    let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    let localURL = URL(string: encodedString)!
   
    // Try Catch
    do {
        // 5-1. 삭제하기
        try fileManager.removeItem(at: localURL)
    } catch let e {
        // 5-2. 에러처리
        print(e.localizedDescription)
    }
}


var myUser: User!
