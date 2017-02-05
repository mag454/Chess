//
//  ChessPiece.swift
//  Final Project
//
//  Created by Matthew Gianetta on 11/22/16.
//  Copyright © 2016 Matthew Gianetta. All rights reserved.
//

import UIKit

class ChessPiece: UIImageView {

    var name: String
    var location: String
    var color: String
    var row: Int
    var column: String
    
    init(frame: CGRect, name: String, location: String, color: String) {
        self.name = name
        self.location = location
        self.column = location.substring(to: location.index(location.startIndex, offsetBy: 1))
        self.row = Int(location.substring(from: location.index(after: location.startIndex)))!
        self.color = color
        super.init(frame: frame)
        becomeFirstResponder()
        isUserInteractionEnabled = true
        var image = UIImage()
        
        if color == "Black" {
            switch name {
            case "Pawn":
                image = UIImage(named: "Black Pawn")!
            case "Rook":
                image = UIImage(named: "Black Rook")!
            case "Knight":
                image = UIImage(named: "Black Knight")!
            case "Bishop" :
                image = UIImage(named: "Black Bishop")!
            case "Queen":
                image = UIImage(named: "Black Queen")!
            default:
                image = UIImage(named: "Black King")!
            }
        }
        
        if color == "White" {
            switch name {
            case "Pawn":
                image = UIImage(named: "White Pawn")!
            case "Rook":
                image = UIImage(named: "White Rook")!
            case "Knight":
                image = UIImage(named: "White Knight")!
            case "Bishop" :
                image = UIImage(named: "White Bishop")!
            case "Queen":
                image = UIImage(named: "White Queen")!
            default:
                image = UIImage(named: "White King")!
            }
        }
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.image = image
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
}
