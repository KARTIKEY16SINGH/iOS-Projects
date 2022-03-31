//
//  LazyUIImageView.swift
//  Dunzo
//
//  Created by Iron Man on 16/03/22.
//

import UIKit

class LazyUIImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
//    static let cache = NSCache<, UIImage>()
    
    func loadImage(imageUrl: String) {
        DispatchQueue.global().async {
            if let url = URL(string: imageUrl) {
                if let imageData = try? Data(contentsOf: url) {
                    DispatchQueue.main.async { [weak self] in
                        let uiImage = UIImage(data: imageData)
                        self?.image = uiImage
                    }
                }
            }
        }
    }
}
