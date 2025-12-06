//
//  ViewController.swift
//  RateLimiterLearning
//
//  Created by Iron Man on 24/11/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let retry = RetryEngine(attempts: 5, baseDelay: 1.0, maxDelay: 15.0)

        retry.run(operation: { (done: @escaping(Data?, Error?) -> Void) in

            let url = URL(string: "https://example.com")!
            URLSession.shared.dataTask(with: url) { data, response, error in
//                if let data = data,
//                   let http = response as? HTTPURLResponse,
//                   (200...299).contains(http.statusCode) {
//                    done(data, nil)
//                } else {
                    done(nil, error ?? URLError(.badServerResponse))
//                }
            }.resume()

        }) { result, error in

            if let data = result {
                print("SUCCESS:", data)
            } else {
                print("FAILED after retries:", error!)
            }
        }
    }


}

