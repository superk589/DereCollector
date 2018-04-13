//
//  RankingItem.swift
//  DereCollector
//
//  Created by zzk on 2018/4/12.
//

import Foundation

struct RankingItem {
    
    init(score: UInt, rank: UInt) {
        self.score = score
        self.rank = rank
    }
    
    var score: UInt
    var rank: UInt
}
