//
//  ImageView+Extension.swift
//  GithubSearch
//
//  Created by Iron Man on 06/11/25.
//

import UIKit

extension UIImageView {
    func setImage(from stringUrl: String?) {
        guard let stringUrl, let url = URL(string: stringUrl) else { return }
        DispatchQueue.global().async { [weak self, tag] in
            URLSession.shared.dataTask(with: URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)) {[weak self, tag] data, response, error in
                guard let data, let self, self.tag == tag else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}
