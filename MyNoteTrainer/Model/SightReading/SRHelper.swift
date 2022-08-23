//
//  SRHelper.swift
//  MyNoteTrainer
//
//  Created by Rinaldi Alfian on 21/08/22.
//

import Foundation


class SRHelper {
    static func generateBlock(offsetBeat: Int, notes: [Note]) -> [[Int]] {
        var arr = [Double(offsetBeat)]
        for i in notes {
            arr.append(i.noteType.beat.rawValue)
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
//            print("generated box count", arr2)
        return arr2
    }
    
    static func convertBeatToTimeInterval(notes: [Note], bpm: Int, offsetBpm: Int?) -> [TimeInterval]{
        //beat [1,1,1] -> timeinterval [0, 1, 1, 1->stop]
        //beat [1, 0.5, 1, 0.5] -> timeInterval [0, 1, 0.5, 1, 0.5->stop]
        //offsetBpm 3 -> timeinterval [1, 1, 1] [4, 1, 0.5, 1, 0.5-> stop]
        //bear [1,1,1] -> 120bpm -> [3.5,0,5,0,5]
        let interval : Double = 60.0 / Double(bpm)
        var beatsTimeInterval : [TimeInterval] = [] //last stop
        if let _ = offsetBpm {
            beatsTimeInterval.append(TimeInterval(Double(offsetBpm!)*interval))
        } else {
            beatsTimeInterval.append(TimeInterval(interval))
        }
        for note in notes {
            beatsTimeInterval.append(TimeInterval(Double(60.0 * note.noteType.beat.rawValue / Double(bpm))))
        }
        return beatsTimeInterval
    }
    
    static func countNoteTiming(noteInterval: [TimeInterval]) -> [TimeInterval] {
        var currentTotal : TimeInterval = 0
        let res = noteInterval.enumerated().map{ (index, inv) -> TimeInterval in
            if(index > 0) {
                currentTotal += inv
            } else {
                currentTotal = inv
            }
            return currentTotal
        }
        return res
    }
}



