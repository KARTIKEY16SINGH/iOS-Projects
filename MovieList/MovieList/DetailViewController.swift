//
//  DetailViewController.swift
//  MovieList
//
//  Created by Iron Man on 21/05/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DetailManager.shared.getDetails { [weak self] model in
            guard let _ = self else {return}
            DispatchQueue.main.async {
                self!.movieTitle.text = model.title
                var text = "Year = \(model.year)\n"
                text += "Actors = \(model.casts)\n"
                text += "Plot = \(model.plot)"
                self!.textView.text = text
            }
            
            
            DetailManager.shared.getImage(url: model.imageURL) { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.icon.image = UIImage(data: data)
                }
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
