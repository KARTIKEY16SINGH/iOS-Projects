//
//  BookingRequestViewController.swift
//  GoMmt
//
//  Created by Iron Man on 11/04/21.
//

import UIKit

class BookingRequestViewController: UIViewController {

    @IBOutlet weak var declineButton : UIButton!
    @IBOutlet weak var approveButton : UIButton!
    @IBOutlet weak var bookingRequestLbl : UILabel!
    @IBOutlet weak var requesterLabel : UILabel!
    @IBOutlet weak var expiryLabel : UILabel!
    @IBOutlet weak var rquesterStatsLbl : UILabel!
    @IBOutlet weak var mmtBlackPlusImageView : UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    private func setupViews() {
        declineButton.layer.borderWidth = 1
        declineButton.layer.borderColor = #colorLiteral(red: 0.6271458268, green: 0.5828235149, blue: 0.8711469769, alpha: 1)
        declineButton.layer.cornerRadius = 5
        approveButton.layer.cornerRadius = 5
        mmtBlackPlusImageView.layer.borderWidth = 2
        mmtBlackPlusImageView.layer.borderColor = #colorLiteral(red: 0.4862242937, green: 0.4863099456, blue: 0.4905173779, alpha: 1)
        mmtBlackPlusImageView.layer.cornerRadius = 5
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

fileprivate extension UILabel {
    func setCurrencyText(_ text : String) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        self.text = formatter.currencySymbol + " " + text
    }
}
