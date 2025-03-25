//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Meredith Luo on 2025/3/23.
//

import Foundation

class TriviaQuestionService {
    
    static func fetchTriviaQuestion(completion: (([TriviaQuestion]) -> Void)? = nil) {
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        
        let task = URLSession.shared.dataTask(with: url) {data, response, error in
            // this closure is fired when the response is received
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResonse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResonse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResonse.statusCode)")
                return
            }
            let decoder = JSONDecoder()
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            
            DispatchQueue.main.async {
                completion?(response.results)
            }
        }
        task.resume()
    }
}
