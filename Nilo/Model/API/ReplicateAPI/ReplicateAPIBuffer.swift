//
//  ReplicateAPIBuffer.swift
//  Nilo
//
//  Created by Joao Pedro Monteiro Maia on 07/10/22.
//

import Foundation
import CodableExtensions
import CryptoKit

class ReplicateAPIBuffer:Codable{
    var name:String
    var buffer:[ReplicateAPIPredictionInfo] = [] {
        didSet{
            buffer = buffer.sorted { $0.createdAt > $1.createdAt }
        }
    }
    
    init(fromToken token:String){
        self.name = ReplicateAPIBuffer.tokenToSHA(token)
    }
    
    func append(_ newItem:ReplicateAPIPredictionInfo){
        //buffer.append(item)
        var i  = 0
        for item in buffer{
            if(item.id == newItem.id){
               buffer[i] = newItem
                return
            }
            i+=1
        }
        
        buffer.append(newItem)
    }
    
    func markAsPresented(id:String){
        buffer.forEach(){ item in
            if (item.id == id){
                item.presented.toggle()
                return
            }
        }
    }
    
    func getLast()->ReplicateAPIPredictionInfo?{
        return buffer.sorted { $0.createdAt > $1.createdAt }.first
    }
    
    static func tokenToSHA(_ token:String)->String{
        let sha = SHA256.hash(data: token.data(using: .utf8)!)
        return sha.description.replacingOccurrences(of: "SHA256 digest: ", with: "")
    }
    
}
