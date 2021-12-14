//
//  Model.swift
//  interface-8
//
//  Created by 준난 on 2021/12/14.
//

import Foundation

struct Photo: Identifiable, Decodable {
    var id: String
    var alt_description: String?
    var urls: [String : String]
}

class UnsplashData: ObservableObject {
    @Published var photoArray: [Photo] = []
    
    
    init() {
        loadData()
    }
    
    func loadData() {
        let key = "xqtyRJtwLD8qWhzAPnSAkRi33WmEdoJoAkHGGLu1zuw"
        let url = "https://api.unsplash.com/photos?page=2&client_id=\(key)"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, error) in
            guard let data = data else {
                print("URLSession dataTask error:", error ?? "nil")
                return
            }
            do {
                let json = try JSONDecoder().decode([Photo].self, from: data)
                print(json)
                for photo in json {
                    DispatchQueue.main.async {
                        self.photoArray.append(photo)
                    }
                }
                
            }catch{
                print(error)
            }
            
        }.resume()
        
        
    }
    
    
}


