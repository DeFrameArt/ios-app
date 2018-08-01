//
//  DataStore.swift
//  DeFrameApp
//
//  Created by Maria Kochetygova on 7/24/18.
//  Copyright © 2018 DeFrame. All rights reserved.
//

import UIKit

class DataStore {
   /* private var museums = emoji.map { EmojiRating(emoji: $0, rating: "") }
    
    public var numberOfEmoji: Int {
        return emojiRatings.count
    }
    
    public func loadEmojiRating(at index: Int) -> DataLoadOperation? {
        if (0..<emojiRatings.count).contains(index) {
            return DataLoadOperation(emojiRatings[index])
        }
        return .none
    }
    
    public func update(emojiRating: Museum) {
        if let index = emojiRatings.index(where: { $0.emoji == emojiRating.emoji }) {
            emojiRatings.replaceSubrange(index...index, with: [emojiRating])
        }
    }
}


class DataLoadOperation: Operation {
    var emojiRating: EmojiRating?
    var loadingCompleteHandler: ((EmojiRating) -> ())?
    
    private let _emojiRating: EmojiRating
    
    init(_ emojiRating: EmojiRating) {
        _emojiRating = emojiRating
    }
    
    override func main() {
        if isCancelled { return }
        
        let randomDelayTime = arc4random_uniform(2000) + 500
        usleep(randomDelayTime * 1000)
        
        if isCancelled { return }
        self.emojiRating = _emojiRating
        
        if let loadingCompleteHandler = loadingCompleteHandler {
            DispatchQueue.main.async {
                loadingCompleteHandler(self._emojiRating)
            }
        }
    }
    */
}
