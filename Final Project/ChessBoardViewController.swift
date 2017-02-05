//
//  ChessBoardViewController.swift
//  Final Project
//
//  Created by Matthew Gianetta on 11/22/16.
//  Copyright © 2016 Matthew Gianetta. All rights reserved.
//

import UIKit

class ChessBoardViewController: UIViewController {

    var squareSize: CGFloat = 0
    var indexNumToLetter = ["A", "B", "C", "D", "E", "F", "G", "H"]
    var indexLetterToNum = ["A": 1, "B": 2, "C":3, "D":4, "E":5, "F":6, "G":7, "H":8]
    var squareDictionary = [String:UIButton]()
    var blackPieces = [ChessPiece]()
    var whitePieces = [ChessPiece]()
    var selectedPiece: ChessPiece?
    var pieceToRemove: ChessPiece?
    var possibleMoveLocations = [String]()
    var whiteTurn = true
    var whiteCanCastleLeft = true
    var whiteCanCastleRight = true
    var blackCanCastleLeft = true
    var blackCanCastleRight = true
    var enPassantCount = 1
    var enPassantPieceLocation: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        if self.view.frame.height > self.view.frame.width {
            squareSize = (self.view.frame.width / 8) - 10
        }
        else {
            squareSize = (self.view.frame.height / 8) - 10
        }
        
        for yIndex in 1...8 {
            for xIndex in 1...8 {
                
            let square = UIButton(frame: CGRect(x: 40 + (CGFloat(xIndex-1) * squareSize), y: 40 + 8 * squareSize -  (CGFloat(yIndex - 1) * squareSize), width: squareSize, height: squareSize))
                
                if (yIndex + xIndex) % 2 == 0 {
                    square.backgroundColor = UIColor.brown
                }
                else {
                    square.backgroundColor = UIColor.lightGray
                }
                
                square.setTitle(indexNumToLetter[xIndex - 1] + String(yIndex), for: .normal)
                square.setTitleColor(UIColor.clear, for: .normal)
                squareDictionary.updateValue(square, forKey: (square.titleLabel?.text)!)
                square.addTarget(self, action: #selector(moveToLocation(senderButton: )), for: .touchUpInside)
                view.addSubview(square)
                
            }
        }
        
        initializePieces()
        
    }
    
    func initializePieces() {
        for blackPawn in 1...8 {
            let pawn = ChessPiece(frame: (squareDictionary[indexNumToLetter[blackPawn-1] + "7"]?.frame)!, name: "Pawn", location: (squareDictionary[indexNumToLetter[blackPawn-1] + "7"]?.titleLabel?.text)!, color: "Black")
            blackPieces.append(pawn)
            view.addSubview(pawn)
        }
        
        let blackRook1 = ChessPiece(frame: (squareDictionary["A8"]?.frame)!, name: "Rook", location: "A8", color: "Black")
        blackPieces.append(blackRook1)
        view.addSubview(blackRook1)
        
        let blackRook2 = ChessPiece(frame: (squareDictionary["H8"]?.frame)!, name: "Rook", location: "H8", color: "Black")
        blackPieces.append(blackRook2)
        view.addSubview(blackRook2)
        
        let blackKnight1 = ChessPiece(frame: (squareDictionary["B8"]?.frame)!, name: "Knight", location: "B8", color: "Black")
        blackPieces.append(blackKnight1)
        view.addSubview(blackKnight1)
        
        let blackKnight2 = ChessPiece(frame: (squareDictionary["G8"]?.frame)!, name: "Knight", location: "G8", color: "Black")
        blackPieces.append(blackKnight2)
        view.addSubview(blackKnight2)
        
        let blackBishop1 = ChessPiece(frame: (squareDictionary["C8"]?.frame)!, name: "Bishop", location: "C8", color: "Black")
        blackPieces.append(blackBishop1)
        view.addSubview(blackBishop1)
        
        let blackBishop2 = ChessPiece(frame: (squareDictionary["F8"]?.frame)!, name: "Bishop", location: "F8", color: "Black")
        blackPieces.append(blackBishop2)
        view.addSubview(blackBishop2)
        
        let blackQueen = ChessPiece(frame: (squareDictionary["D8"]?.frame)!, name: "Queen", location: "D8", color: "Black")
        blackPieces.append(blackQueen)
        view.addSubview(blackQueen)
        
        let blackKing = ChessPiece(frame: (squareDictionary["E8"]?.frame)!, name: "King", location: "E8", color: "Black")
        blackPieces.append(blackKing)
        view.addSubview(blackKing)
        
        for whitePawn in 1...8 {
            let pawn = ChessPiece(frame: (squareDictionary[indexNumToLetter[whitePawn-1] + "2"]?.frame)!, name: "Pawn", location: (squareDictionary[indexNumToLetter[whitePawn-1] + "2"]?.titleLabel?.text)!, color: "White")
            whitePieces.append(pawn)
            view.addSubview(pawn)
        }
        
        let whiteRook1 = ChessPiece(frame: (squareDictionary["A1"]?.frame)!, name: "Rook", location: "A1", color: "White")
        whitePieces.append(whiteRook1)
        view.addSubview(whiteRook1)
                
        let whiteRook2 = ChessPiece(frame: (squareDictionary["H1"]?.frame)!, name: "Rook", location: "H1", color: "White")
        whitePieces.append(whiteRook2)
        view.addSubview(whiteRook2)
        
        let whiteKnight1 = ChessPiece(frame: (squareDictionary["B1"]?.frame)!, name: "Knight", location: "B1", color: "White")
        whitePieces.append(whiteKnight1)
        view.addSubview(whiteKnight1)
        
        let whiteKnight2 = ChessPiece(frame: (squareDictionary["G1"]?.frame)!, name: "Knight", location: "G1", color: "White")
        whitePieces.append(whiteKnight2)
        view.addSubview(whiteKnight2)
        
        let whiteBishop1 = ChessPiece(frame: (squareDictionary["C1"]?.frame)!, name: "Bishop", location: "C1", color: "White")
        whitePieces.append(whiteBishop1)
        view.addSubview(whiteBishop1)
        
        let whiteBishop2 = ChessPiece(frame: (squareDictionary["F1"]?.frame)!, name: "Bishop", location: "F1", color: "White")
        whitePieces.append(whiteBishop2)
        view.addSubview(whiteBishop2)
        
        let whiteQueen = ChessPiece(frame: (squareDictionary["D1"]?.frame)!, name: "Queen", location: "D1", color: "White")
        whitePieces.append(whiteQueen)
        view.addSubview(whiteQueen)
        
        let whiteKing = ChessPiece(frame: (squareDictionary["E1"]?.frame)!, name: "King", location: "E1", color: "White")
        whitePieces.append(whiteKing)
        view.addSubview(whiteKing)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        if whiteTurn == true {
            for chessPiece in whitePieces {
                if let touchLocation = touches.first?.location(in: chessPiece) {
                    if  chessPiece.point(inside: touchLocation, with: event) {
                        selectedPiece = chessPiece
                        pieceToRemove = nil
                    }
                }
            }
            if selectedPiece != nil {
                for chessPiece in blackPieces {
                    if let touchLocation = touches.first?.location(in: chessPiece) {
                        if  chessPiece.point(inside: touchLocation, with: event) {
                            pieceToRemove = chessPiece
                        }
                    }
                }
            }
        }
        else {
            for chessPiece in blackPieces {
                if let touchLocation = touches.first?.location(in: chessPiece) {
                    if  chessPiece.point(inside: touchLocation, with: event) {
                        selectedPiece = chessPiece
                        pieceToRemove = nil
                    }
                }
            }
            if selectedPiece != nil {
                for chessPiece in whitePieces {
                    if let touchLocation = touches.first?.location(in: chessPiece) {
                        if  chessPiece.point(inside: touchLocation, with: event) {
                            pieceToRemove = chessPiece
                        }
                    }
                }
            }
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        possibleMoveLocations = []
        
        if let pieceToMove = selectedPiece {
            
            switch pieceToMove.name {
            case "Pawn":
                getPawnPossibleMoves()
            case "Rook":
                getRookPossibleMoves()
            case "Knight":
                getKnightPossibleMoves()
            case "Bishop" :
                getBishopPossibleMoves()
            case "Queen":
                getBishopPossibleMoves()
                getRookPossibleMoves()
            case "King":
                getPossibleKingMoves()
            default:
                break
            }
        }
        if pieceToRemove != nil {
            for location in possibleMoveLocations {
                if pieceToRemove?.location == location {
                    if selectedPiece?.name == "Pawn" {
                        if location.substring(to: location.index(location.startIndex, offsetBy: 1)) == selectedPiece?.column {
                            break
                        }
                    }
                    
                    enPassantCount = enPassantCount + 1
                    
                    var pieceName = selectedPiece?.name
                    
                    if selectedPiece?.name == "Pawn" && selectedPiece?.color == "White" {
                        if location.substring(from: location.index(after: location.startIndex)) == "8" {
                            pieceName = "Queen"
                        }
                    }
                    
                    if selectedPiece?.name == "Pawn" && selectedPiece?.color == "Black" {
                        if location.substring(from: location.index(after: location.startIndex)) == "1" {
                            pieceName = "Queen"
                        }
                    }
                    
                    let newPiece = ChessPiece(frame: (pieceToRemove?.frame)!, name: (pieceName)!, location: location, color: (selectedPiece?.color)!)
                    if newPiece.color == "White" {
                        whitePieces.append(newPiece)
                        
                    }
                    else {
                        blackPieces.append(newPiece)
    
                    }
                    view.addSubview(newPiece)
                    view.bringSubview(toFront: newPiece)
                    
                    if selectedPiece?.location == "A1" || selectedPiece?.location == "E1" || newPiece.location == "A1" {
                        whiteCanCastleLeft = false
                    }
                    
                    if selectedPiece?.location == "H1" || selectedPiece?.location == "E1" || newPiece.location == "H1" {
                        whiteCanCastleRight = false
                    }
                    
                    if selectedPiece?.location == "A8" || selectedPiece?.location == "E8" || newPiece.location == "A8" {
                        blackCanCastleLeft = false
                    }
                    
                    if selectedPiece?.location == "H8" || selectedPiece?.location == "E8" || newPiece.location == "H8" {
                        blackCanCastleRight = false
                    }
                    
                    removePiece(pieceToRemove: pieceToRemove!)
                    removePiece(pieceToRemove: selectedPiece!)
                    selectedPiece = nil
                    possibleMoveLocations = [String]()
                    whiteTurn = !whiteTurn
                    pieceToRemove = nil
                }
            }
        }
    }
    
    func moveToLocation(senderButton: UIButton) {
        if selectedPiece != nil {
            
            enPassantCount = enPassantCount + 1
            
            if selectedPiece?.color == "White" {
                
                let newLocation = senderButton.currentTitle!
                
                for location in possibleMoveLocations {
                    if newLocation == location {
                        
                        let newPiece = ChessPiece(frame: senderButton.frame, name: (selectedPiece?.name)!, location: newLocation, color: (selectedPiece?.color)!)
                        whitePieces.append(newPiece)
                        view.addSubview(newPiece)
                        view.bringSubview(toFront: newPiece)
                        
                        if newPiece.name == "Pawn" {
                            if (newPiece.row - (selectedPiece?.row)!) == 2 {
                                enPassantCount = 0
                            }
                            if newPiece.location.substring(to: location.index(location.startIndex, offsetBy: 1)) != selectedPiece?.location.substring(to: location.index(location.startIndex, offsetBy: 1)) {
                                for blackPiece in blackPieces {
                                    if blackPiece.location == newPiece.column + String(newPiece.row - 1) {
                                        removePiece(pieceToRemove: blackPiece)
                                    }
                                }
                            }
                        }
                        
                        if newPiece.name == "King" {
                            if  whiteCanCastleLeft {
                                if newPiece.location == "C1" {
                                    for chessPiece in whitePieces {
                                        if chessPiece.location == "A1" {
                                            let castledRook = ChessPiece(frame: (squareDictionary["D1"]?.frame)!, name: (chessPiece.name), location: "D1", color: (chessPiece.color))
                                            whitePieces.append(castledRook)
                                            view.addSubview(castledRook)
                                            view.bringSubview(toFront: castledRook)
                                            
                                            removePiece(pieceToRemove: chessPiece)
                                        }
                                    }
                                }
                            }
                            
                            if whiteCanCastleRight {
                                if newPiece.location == "G1" {
                                    for chessPiece in whitePieces {
                                        if chessPiece.location == "H1" {
                                            let castledRook = ChessPiece(frame: (squareDictionary["F1"]?.frame)!, name: (chessPiece.name), location: "F1", color: (chessPiece.color))
                                            whitePieces.append(castledRook)
                                            view.addSubview(castledRook)
                                            view.bringSubview(toFront: castledRook)
                                            
                                            removePiece(pieceToRemove: chessPiece)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if selectedPiece?.location == "A1" || selectedPiece?.location == "E1" {
                            whiteCanCastleLeft = false
                        }
                        
                        if selectedPiece?.location == "H1" || selectedPiece?.location == "E1" {
                            whiteCanCastleRight = false
                        }
                        
                        removePiece(pieceToRemove: selectedPiece!)
                        selectedPiece = nil
                        possibleMoveLocations = [String]()
                        whiteTurn = !whiteTurn
                        break
                    }
                }
            }
            
            if selectedPiece?.color == "Black" {
                
                let newlocation = senderButton.currentTitle!
                
                for location in possibleMoveLocations {
                    if newlocation == location {
                        
                        let newPiece = ChessPiece(frame: senderButton.frame, name: (selectedPiece?.name)!, location: newlocation, color: (selectedPiece?.color)!)
                        blackPieces.append(newPiece)
                        view.addSubview(newPiece)
                        view.bringSubview(toFront: newPiece)
                        
                        if newPiece.name == "Pawn" {
                            if ((selectedPiece?.row)! - newPiece.row) == 2 {
                                enPassantCount = 0
                            }
                            if newPiece.location.substring(to: location.index(location.startIndex, offsetBy: 1)) != selectedPiece?.location.substring(to: location.index(location.startIndex, offsetBy: 1)) {
                                for whitePiece in whitePieces {
                                    if whitePiece.location == newPiece.column + String(newPiece.row + 1) {
                                        removePiece(pieceToRemove: whitePiece)
                                    }
                                }
                            }
                        }
                        
                        if newPiece.name == "King" {
                            if  blackCanCastleLeft {
                                if newPiece.location == "C8" {
                                    for chessPiece in blackPieces {
                                        if chessPiece.location == "A8" {
                                            let castledRook = ChessPiece(frame: (squareDictionary["D8"]?.frame)!, name: (chessPiece.name), location: "D8", color: (chessPiece.color))
                                            blackPieces.append(castledRook)
                                            view.addSubview(castledRook)
                                            view.bringSubview(toFront: castledRook)
                                            
                                            removePiece(pieceToRemove: chessPiece)
                                        }
                                    }
                                }
                            }
                            
                            if blackCanCastleRight {
                                if newPiece.location == "G8" {
                                    for chessPiece in blackPieces {
                                        if chessPiece.location == "H8" {
                                            let castledRook = ChessPiece(frame: (squareDictionary["F8"]?.frame)!, name: (chessPiece.name), location: "F8", color: (chessPiece.color))
                                            blackPieces.append(castledRook)
                                            view.addSubview(castledRook)
                                            view.bringSubview(toFront: castledRook)
                                            
                                            removePiece(pieceToRemove: chessPiece)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if selectedPiece?.location == "A8" || selectedPiece?.location == "E8" {
                            blackCanCastleLeft = false
                        }
                        
                        if selectedPiece?.location == "H8" || selectedPiece?.location == "E8" {
                            blackCanCastleRight = false
                        }
                        
                        removePiece(pieceToRemove: selectedPiece!)
                        selectedPiece = nil
                        possibleMoveLocations = [String]()
                        whiteTurn = !whiteTurn
                    }
                }
            }
        }
    }
    
    func removePiece(pieceToRemove: ChessPiece) {
        if pieceToRemove.color == "White" {
            for chessPiece in whitePieces {
                if pieceToRemove == chessPiece {
                    whitePieces = whitePieces.filter {$0 != chessPiece }
                }
            }
        }
        else {
            for chessPiece in blackPieces {
                if pieceToRemove == chessPiece {
                    blackPieces = blackPieces.filter {$0 != chessPiece }
                }
            }
        }
        pieceToRemove.removeFromSuperview()
    }
    
    func getBishopPossibleMoves() {
        
        if let pieceToMove = selectedPiece {
            
            var columnAsNum = indexLetterToNum[pieceToMove.column]!
            var row = pieceToMove.row
            
            outerLoop: while row <= 8 && columnAsNum <= 8 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row + 1
                columnAsNum = columnAsNum + 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            outerLoop: while row >= 1 && columnAsNum <= 8 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row - 1
                columnAsNum = columnAsNum + 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            outerLoop: while row >= 1 && columnAsNum >= 1 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row - 1
                columnAsNum = columnAsNum - 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            outerLoop: while row <= 8 && columnAsNum >= 1 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row + 1
                columnAsNum = columnAsNum - 1
            }
            possibleMoveLocations = possibleMoveLocations.filter { $0 != pieceToMove.location }
        }
    }
    
    func getKnightPossibleMoves() {
        
        if let pieceToMove = selectedPiece {
            
            let up1Row = pieceToMove.row + 1
            let up2Rows = pieceToMove.row + 2
            let down1Row = pieceToMove.row - 1
            let down2Rows = pieceToMove.row - 2
            
            if pieceToMove.column == "A" {
                let right1Cloumn = indexNumToLetter[indexLetterToNum[pieceToMove.column]!]
                let right2Cloumns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! + 1]
                
                possibleMoveLocations.append(right1Cloumn + String(up2Rows))
                possibleMoveLocations.append(right1Cloumn + String(down2Rows))
                possibleMoveLocations.append(right2Cloumns + String(up1Row))
                possibleMoveLocations.append(right2Cloumns + String(down1Row))
            }
            else if pieceToMove.column == "B" {
                let left1Column = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2]
                let right1Cloumn = indexNumToLetter[indexLetterToNum[pieceToMove.column]!]
                let right2Cloumns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! + 1]
                
                possibleMoveLocations.append(left1Column + String(up2Rows))
                possibleMoveLocations.append(left1Column + String(down2Rows))
                possibleMoveLocations.append(right1Cloumn + String(up2Rows))
                possibleMoveLocations.append(right1Cloumn + String(down2Rows))
                possibleMoveLocations.append(right2Cloumns + String(up1Row))
                possibleMoveLocations.append(right2Cloumns + String(down1Row))
            }
            else if pieceToMove.column == "H" {
                let left1Column = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2]
                let left2Columns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 3]
                
                possibleMoveLocations.append(left1Column + String(up2Rows))
                possibleMoveLocations.append(left1Column + String(down2Rows))
                possibleMoveLocations.append(left2Columns + String(up1Row))
                possibleMoveLocations.append(left2Columns + String(down1Row))
            }
            else if pieceToMove.column == "G" {
                let left1Column = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2]
                let left2Columns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 3]
                let right1Cloumn = indexNumToLetter[indexLetterToNum[pieceToMove.column]!]
                
                possibleMoveLocations.append(left1Column + String(up2Rows))
                possibleMoveLocations.append(left1Column + String(down2Rows))
                possibleMoveLocations.append(left2Columns + String(up1Row))
                possibleMoveLocations.append(left2Columns + String(down1Row))
                possibleMoveLocations.append(right1Cloumn + String(up2Rows))
                possibleMoveLocations.append(right1Cloumn + String(down2Rows))
            }
            else {
                let left1Column = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2]
                let left2Columns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 3]
                let right1Cloumn = indexNumToLetter[indexLetterToNum[pieceToMove.column]!]
                let right2Cloumns = indexNumToLetter[indexLetterToNum[pieceToMove.column]! + 1]
                
                possibleMoveLocations.append(left1Column + String(up2Rows))
                possibleMoveLocations.append(left1Column + String(down2Rows))
                possibleMoveLocations.append(left2Columns + String(up1Row))
                possibleMoveLocations.append(left2Columns + String(down1Row))
                possibleMoveLocations.append(right1Cloumn + String(up2Rows))
                possibleMoveLocations.append(right1Cloumn + String(down2Rows))
                possibleMoveLocations.append(right2Cloumns + String(up1Row))
                possibleMoveLocations.append(right2Cloumns + String(down1Row))
            }
        }
    }
    
    func getRookPossibleMoves() {
        if let pieceToMove = selectedPiece {
            var columnAsNum = indexLetterToNum[pieceToMove.column]!
            var row = pieceToMove.row
            
            
            outerLoop: while row <= 8 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row + 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            outerLoop: while row >= 1 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                row = row - 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            
            outerLoop: while columnAsNum >= 1 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                columnAsNum = columnAsNum - 1
            }
            
            columnAsNum = indexLetterToNum[pieceToMove.column]!
            row = pieceToMove.row
            
            
            outerLoop: while columnAsNum <= 8 {
                if whiteTurn {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                            
                            
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                        }
                    }
                }
                else {
                    for chessPiece in whitePieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) {
                            possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                            break outerLoop
                            
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == indexNumToLetter[(columnAsNum - 1)] + String(row) && chessPiece.location != pieceToMove.location {
                            break outerLoop
                        }
                    }
                }
                possibleMoveLocations.append(indexNumToLetter[(columnAsNum - 1)] + String(row))
                columnAsNum = columnAsNum + 1
            }
            possibleMoveLocations = possibleMoveLocations.filter { $0 != pieceToMove.location }
        }
    }
    
    func getPawnPossibleMoves() {
        if let pieceToMove = selectedPiece {
            if pieceToMove.color == "White" {
                possibleMoveLocations = [pieceToMove.column + String(pieceToMove.row + 1)]
                
                if pieceToMove.column != "A" {
                    let takeLeft = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2] +
                        String(pieceToMove.row + 1)
                    for blackPiece in blackPieces {
                        if blackPiece.location == takeLeft {
                            possibleMoveLocations.append(takeLeft)
                        }
                        let enPassantCheckLocation = takeLeft.substring(to: takeLeft.index(takeLeft.startIndex, offsetBy: 1))
                        if blackPiece.location == enPassantCheckLocation + String(pieceToMove.row) && enPassantCount == 0 {
                            possibleMoveLocations.append(takeLeft)
                        }
                    }
                }
                if pieceToMove.column != "H" {
                    let takeRight = indexNumToLetter[indexLetterToNum[pieceToMove.column]!] +
                        String(pieceToMove.row + 1)
                    for blackPiece in blackPieces {
                        if blackPiece.location == takeRight {
                            possibleMoveLocations.append(takeRight)
                        }
                        let enPassantCheckLocation = takeRight.substring(to: takeRight.index(takeRight.startIndex, offsetBy: 1))
                        if blackPiece.location == enPassantCheckLocation + String(pieceToMove.row) && enPassantCount == 0 {
                            possibleMoveLocations.append(takeRight)
                        }
                    }
                }
                if pieceToMove.row == 2 {
                    possibleMoveLocations.append(pieceToMove.column + String(pieceToMove.row + 2))
                }
            }
            else {
                possibleMoveLocations = [pieceToMove.column + String(pieceToMove.row - 1)]
                
                if pieceToMove.column != "A" {
                    let takeLeft = indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2] +
                        String(pieceToMove.row - 1)
                    for whitePiece in whitePieces {
                        if whitePiece.location == takeLeft {
                            possibleMoveLocations.append(takeLeft)
                        }
                        let enPassantCheckLocation = takeLeft.substring(to: takeLeft.index(takeLeft.startIndex, offsetBy: 1))
                        if whitePiece.location == enPassantCheckLocation + String(pieceToMove.row) && enPassantCount == 0 {
                            possibleMoveLocations.append(takeLeft)
                        }
                    }
                }
                if pieceToMove.column != "H" {
                    let takeRight = indexNumToLetter[indexLetterToNum[pieceToMove.column]!] +
                        String(pieceToMove.row - 1)
                    for whitePiece in whitePieces {
                        if whitePiece.location == takeRight {
                            possibleMoveLocations.append(takeRight)
                        }
                        let enPassantCheckLocation = takeRight.substring(to: takeRight.index(takeRight.startIndex, offsetBy: 1))
                        if whitePiece.location == enPassantCheckLocation + String(pieceToMove.row) && enPassantCount == 0 {
                            possibleMoveLocations.append(takeRight)
                        }
                    }
                }
                if pieceToMove.row == 7 {
                    possibleMoveLocations.append(pieceToMove.column + String(pieceToMove.row - 2))
                }
            }
        }
    }
    
    func getPossibleKingMoves() {
        if let pieceToMove = selectedPiece {
            possibleMoveLocations = [pieceToMove.column + String(pieceToMove.row + 1)]
            possibleMoveLocations.append(pieceToMove.column + String(pieceToMove.row - 1))
            
            if pieceToMove.column != "A" {
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2] +
                    String(pieceToMove.row + 1))
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2] + String(pieceToMove.row))
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]! - 2] + String(pieceToMove.row - 1))
            }
            
            if pieceToMove.column != "H" {
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]!] +
                    String(pieceToMove.row + 1))
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]!] +
                    String(pieceToMove.row))
                possibleMoveLocations.append(indexNumToLetter[indexLetterToNum[pieceToMove.column]!] +
                    String(pieceToMove.row - 1))
                
            }
            
            if pieceToMove.color == "White" {
                outerIf : if whiteCanCastleLeft {
                    for chessPiece in whitePieces {
                        if chessPiece.location == "B1" || chessPiece.location == "C1" || chessPiece.location == "D1" {
                            break outerIf
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == "B1" || chessPiece.location == "C1" || chessPiece.location == "D1" {
                            break outerIf
                        }
                    }
                    
                    possibleMoveLocations.append("C1")
                }
                
                outerIf : if whiteCanCastleRight {
                    for chessPiece in whitePieces {
                        if chessPiece.location == "F1" || chessPiece.location == "G1"  {
                            break outerIf
                        }
                    }
                    for chessPiece in blackPieces {
                        if chessPiece.location == "F1" || chessPiece.location == "G1"  {
                            break outerIf
                        }
                    }
                    
                    possibleMoveLocations.append("G1")
                }
            }
            else {
                outerIf : if blackCanCastleLeft {
                    for chessPiece in blackPieces {
                        if chessPiece.location == "B8" || chessPiece.location == "C8" || chessPiece.location == "D8" {
                            break outerIf
                        }
                    }
                    for chessPiece in whitePieces {
                        if chessPiece.location == "B8" || chessPiece.location == "C8" || chessPiece.location == "D8" {
                            break outerIf
                        }
                    }
                    
                    possibleMoveLocations.append("C8")
                }
                
                outerIf : if blackCanCastleRight {
                    for chessPiece in blackPieces {
                        if chessPiece.location == "F8" || chessPiece.location == "G8"  {
                            break outerIf
                        }
                    }
                    for chessPiece in whitePieces {
                        if chessPiece.location == "F8" || chessPiece.location == "G8"  {
                            break outerIf
                        }
                    }
                    
                    possibleMoveLocations.append("G8")
                }
            }
        }
    }
}

