//
//  Helper.swift
//  quint
//
//  Created by Widya Limarto on 13/05/22.
//

import Foundation
import SwiftUI

class Helper {
    static func getXInitialOffset(generatedBlock: [[Int]]) -> CGFloat {
        return CGFloat(Config.BLOCK_WIDTH * generatedBlock.count / 2)
    }
    
    static func arrToColumn(data : [Sound], col: Int) -> [[Sound]] {
        var index : Int = 0
        var res : [[Sound]] = []
        while(index < data.count){
            var temp : [Sound] = []
            while(temp.count < col && index != data.count) {
                temp.append(data[index])
                index += 1
            }
            res.append(temp)
            
        }
        return res
    }
}
