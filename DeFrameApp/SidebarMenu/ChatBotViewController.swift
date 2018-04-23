//
//  ChatBotViewController.swift
//  DeFrameApp
//
//  Created by Prashant Verma on 11/13/17.
//  Copyright © 2017 DeFrame. All rights reserved.
//

import Foundation
import AVFoundation
import ApiAI
import UIKit
import MBProgressHUD
import JSQMessagesViewController

struct User {
    
    let id: String
    let name: String
    
}

class ChatBotViewController: JSQMessagesViewController {
    
    let user1 = User(id: "1", name: "Frida")
    
    let user2 = User(id: "2", name: Constants.userName as! String)
    
    var currentUser: User {
        
        return user2
        
    }
    
    // all messages of users1, users2
    
    var messages = [JSQMessage]()
    
}



extension ChatBotViewController {
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        
        finishSendingMessage()
        
        messages.append(message!)
        
        deFrameBotResponse(text)
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath!) -> NSAttributedString! {
        
        let message = messages[indexPath.row]
        
        let messageUsername = message.senderDisplayName
        return NSAttributedString(string: messageUsername!)
        
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAt indexPath: IndexPath!) -> CGFloat {
        
        return 15
        
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        return nil
        
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        let message = messages[indexPath.row]
        
        let botColor = UIColor(red: 200/255.0, green: 31/255.0, blue: 97/255.0, alpha: 0.839)
        
        if currentUser.id == message.senderId {
            
            return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
            
        } else {
            
            return bubbleFactory?.incomingMessagesBubbleImage(with: botColor)
            
        }
        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
        
    }
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.row]
        
    }
    
}



extension ChatBotViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //To remove attachment buutton on the leftof input text field
        
        self.inputToolbar.contentView.leftBarButtonItem = nil;
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
        // tell JSQMessagesViewController
        
        // who is the current user
        
        self.senderId = currentUser.id
        
        self.senderDisplayName = currentUser.name
        
        self.messages = getMessages()
        
    }
    
}



extension ChatBotViewController {
    
    func getMessages() -> [JSQMessage] {
        
        var messages = [JSQMessage]()
        
        let message1 = JSQMessage(senderId: "1", displayName: "Frida", text: "Hi, I am Frida. How may I help you? ")
        
        //let message2 = JSQMessage(senderId: "2", displayName: "Tim", text: "MFA")
        messages.append(message1!)
        return messages
        
    }
    
    
    
    func deFrameBotResponse(_ chatMessage: String) {
        
        if chatMessage != "" {
            
            //initiate APIAI
            
            let request: AITextRequest? = ApiAI.shared().textRequest()
            
            request?.query = chatMessage
            
            weak var selfWeak = self
            
            request?.setMappedCompletionBlockSuccess({(request, response) in
                
                let response  = response as! AIResponse
                
                let alertView = UIAlertView(title: response.status.errorType, message: response.result.fulfillment.speech, delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
                
                let responseMessage = JSQMessage(senderId: "1", displayName: "Frida", text: response.result.fulfillment.speech)
                
                self.messages.append(responseMessage!)
                
                // self.collectionView.reloadData()
                
                self.finishReceivingMessage()
                
            }, failure: {(request, error) in
                
                let selfStrong = selfWeak
                
                let alertView = UIAlertView(title: "Error", message: (error?.localizedDescription)!, delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "")
                
                alertView.show()
                
                MBProgressHUD.hide(for: (selfStrong?.view)!, animated: true)
                
            })
            
            ApiAI.shared().enqueue(request)
            
        }
        
    }
    
    
    
}

