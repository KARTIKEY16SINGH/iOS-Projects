//
//  UnderlinedTextField.swift
//  LocusAssignment
//
//  Created by Iron Man on 11/04/22.
//

import UIKit

@IBDesignable class UnderlinedTextField: UITextField {
    @IBInspectable var borderHeight: CGFloat = 1
    @IBInspectable var borderColor: UIColor = .gray
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let underlineLayer = CALayer()
        underlineLayer.frame = CGRect(x: 0, y: self.layer.frame.height - borderHeight, width: self.layer.frame.width, height: borderHeight)
        self.borderStyle = .none
        underlineLayer.backgroundColor = borderColor.cgColor
        self.layer.addSublayer(underlineLayer)
    }

}
