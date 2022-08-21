//
//  SRHelper.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import Foundation


class SRHelper {
    static func generateBlock(offsetBpm: Int, notes: [Note]) -> [[Int]] {
        var arr = [Double(offsetBpm)]
        for i in notes {
            arr.append(i.beat.rawValue)
        }
        var arr2 : [[Int]] = []
        var arr3 : [Int : Int] = [:]
        var isTrue : Bool = true
        for (index,i) in arr.enumerated() {
            var ii = i
            
            while ii > 0{
                var iii : [Int] = []
                iii.append(isTrue ? 1 : 0)
                
                ii -= 0.5
                if arr3[index] == nil {
                    arr3[index] = arr2.count
                    iii.append(index)
                    
                }
                arr2.append(iii)
                isTrue.toggle()
            }
        }
            print("generated box count", arr2)
        return arr2
    }
}

