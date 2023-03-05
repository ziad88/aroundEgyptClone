//
//  DataManager.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 03/03/2023.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateReco(_ DataManager: DataManager, data: [AroundData])
    func didUpdateRecent(_ DataManager: DataManager, data: [AroundData])
    func didUpdateSingleEx(_ DataManager: DataManager, data: AroundData)
    func didFailWithError(error: Error)
}

struct DataManager {
    
    let url = "https://aroundegypt.34ml.com/api/v2"
    var delegate: DataManagerDelegate?
    
    func PostLike(id: String) {
        let urlString = "\(url)/experiences/{\(id)}/like"
        postRequest(with: urlString)
    }
    
    func GetRecommendedExperiences() {
        let urlString = "\(url)/experiences?filter[recommended]=true"
        performRequest(with: urlString, type: "Recommended")
    }
    
    func GetRecentExperiences() {
        let urlString = "\(url)/experiences"
        performRequest(with: urlString, type: "recent")
    }
    
    func GetSearchExperiences(searchText: String) {
        let urlString = "\(url)/experiences?filter[title]={\(searchText)}"
        performRequest(with: urlString, type: "Recommended")
    }
    
    func GetSingleExperience(id: String) {
        let urlString = "\(url)/experiences/{\(id)}"
        performRequest(with: urlString, type: "singleExperience")
    }
    
    func performRequest(with urlString: String, type: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if type == "Recommended" {
                        if let data = self.parseJSON(safeData) {
                            self.delegate?.didUpdateReco(self, data: data)
                        }
                    } else if type == "recent"{
                        if let data = self.parseJSON(safeData) {
                            self.delegate?.didUpdateRecent(self, data: data)
                        }
                    } else {
                        if let data = self.parseSingleExperience(safeData) {
                            self.delegate?.didUpdateSingleEx(self, data: data)
                        }
                    }
                }
                
                    }
                   task.resume()
                }
          
            }

    
    func postRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.httpMethod = "POST"
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        }
    }
    
    func parseJSON(_ aroundData: Data) -> [AroundData]? {
        let decoder = JSONDecoder()
        var aroundDatax = [AroundData]()
        do {
            let decodedData = try decoder.decode(DataModel.self, from: aroundData)
            for i in 0...7 {
                let id = decodedData.data[i].id
                let title = decodedData.data[i].title
                let likesCount = decodedData.data[i].likes_no
                let coverPictureString = decodedData.data[i].cover_photo
                let description = decodedData.data[i].description
                
                let aroundData = AroundData(id: id, title: title, cover_photo: coverPictureString, likes_no: likesCount, description: description)
                aroundDatax.append(aroundData)
            }
            return aroundDatax
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    func parseSingleExperience(_ aroundData: Data) -> AroundData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(DataModel.self, from: aroundData)
           
                let id = decodedData.data[0].id
                let title = decodedData.data[0].title
                let likesCount = decodedData.data[0].likes_no
                let coverPictureString = decodedData.data[0].cover_photo
                let description = decodedData.data[0].description

            let aroundData = AroundData(id: id, title: title, cover_photo: coverPictureString, likes_no: likesCount, description: description)

            return aroundData
        } catch {
            print(error)
            return nil
        }
    }
    
    
}
