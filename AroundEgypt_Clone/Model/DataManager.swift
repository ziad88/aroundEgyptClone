//
//  DataManager.swift
//  AroundEgypt_Clone
//
//  Created by Ziad Alfakharany on 03/03/2023.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdate(_ DataManager: DataManager, data: [AroundData])
    func didFailWithError(error: Error)
}
struct DataManager {
    
    let url = "https://aroundegypt.34ml.com/api/v2"
    var delegate: DataManagerDelegate?
    
    
    func GetRecommendedExperiences() {
        let urlString = "\(url)/experiences?filter[recommended]=true"
        //let urlString = "https://aroundegypt.34ml.com/api/v2/experiences?filter[recommended]=true"
        performRequest(with: urlString)
    }
    
    func GetRecentExperiences() {
        let urlString = "\(url)/experiences"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let data = self.parseJSON(safeData) {
                        self.delegate?.didUpdate(self, data: data)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [AroundData]? {
        let decoder = JSONDecoder()
        var aroundData: [AroundData]!
        do {
            let decodedData = try decoder.decode(DataModel.self, from: data)
            
            for i in 0...7 {
                let id = decodedData.data[i].id
                let title = decodedData.data[i].title
                let likesCount = decodedData.data[i].likes_no
                let coverPictureString = decodedData.data[i].cover_photo
                
                aroundData!.append(AroundData(id: id, title: title, cover_photo: coverPictureString, likes_no: likesCount))
                print(aroundData![i].title)
            }
            return aroundData
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
