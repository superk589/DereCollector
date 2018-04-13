//
//  RankingPage.swift
//  DereCollector
//
//  Created by zzk on 2018/4/12.
//

import Foundation
import MessagePack

struct RankingPage {
    
    var items: [RankingItem]
    
    init?(fromMsgPack pack: MessagePackValue) {
        
        guard let rankings = pack[.string("data")]?[.string("ranking_list")] else { return nil }
        
        items = [RankingItem]()
        
        for ranking in rankings.arrayValue ?? [] {
            let score = ranking[.string("score")]?.unsignedIntegerValue ?? 0
            let rank = ranking[.string("rank")]?.unsignedIntegerValue ?? 0
            let item = RankingItem(score: UInt(score), rank: UInt(rank))
            items.append(item)
        }
        
    }
}
