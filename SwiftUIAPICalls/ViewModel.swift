//
//  ViewModel.swift
//  SwiftUIAPICalls
//
//  Created by Frank Entsie on 2024/02/04.
//

import Foundation


struct Course: Hashable, Codable{
let name:String
let image:String
}

class ViewModel:ObservableObject{
    
    @Published var courses:[Course] = []
    
    func fetch(){
        guard let url = URL (string: "https://iosacademy.io/api/v1/courses/index.php") else {
            return
        }
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, res, error in
            guard let data = data,error == nil else {
                return
            }
            
            //setValue("3850865a99msh677e25c7bb30006p106d25jsn9885040d8ca5", forHTTPHeaderField: "X-RapidAPI-Key")
         
            //convert to json

            do{
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async{
                    self?.courses = courses
                }
            }   catch{
                print(error)
            }
        }
        task.resume()
    }
}

