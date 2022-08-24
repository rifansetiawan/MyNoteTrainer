//
//  Array+Ext.swift
//  MyNoteTrainer
//
//  Created by Widya Limarto on 22/08/22.
//

import Foundation

extension Array {
  mutating func shiftRight(p: Int) {
    for _ in 0..<p {
      append(removeFirst())
    }
  }
}
