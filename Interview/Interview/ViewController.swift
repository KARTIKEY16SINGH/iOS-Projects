//
//  ViewController.swift
//  Interview
//
//  Created by Iron Man on 22/02/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var squareView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let percentage = findPercentage(arr: arr)
        print("Positive Percentage = \(percentage.positive) Negative Percentage = \(percentage.negative)")
        
        print("Array After Removing Duplicates = \(removeDuplicates(arr: arr))")
    }
    
    @IBAction func onClick(_ sender: Any) {
        convertToCircle(sqaure: squareView)
    }
    
    let arr = [1,2,4,-3,-5,-7,2,8]
    
    func findPercentage(arr: [Int]) -> (positive: Int, negative: Int) {
        let positiveNums = arr.filter({$0 >= 0})
        let positivePercentage = positiveNums.count * 100 / arr.count
        return (positivePercentage, 100 - positivePercentage)
    }
   
   
    
    func convertToCircle(sqaure: UIView)  {
        sqaure.layer.cornerRadius = sqaure.layer.frame.height / 2
    }
    
    func removeDuplicates(arr: [Int]) -> [Int] {
        var temp:[Int] = []
        arr.forEach({
            if !temp.contains($0) {
                temp.append($0)
            }
                
        })
        return temp
    }
}

