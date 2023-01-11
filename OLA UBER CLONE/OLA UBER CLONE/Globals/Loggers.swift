//
//  Loggers.swift
//  OLA UBER CLONE
//
//  Created by Iron Man on 05/05/22.
//

import Foundation

func MALog(_ file: String = #fileID, _ lineNumber: Int = #line, _ function: String = #function, printText: String...) {
    NSLog("\(lineNumber) \(file) \(function) : \(printText)")
}
