//
//  Game.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import Foundation

enum GameDirection {
    case Up
    case Left
    case Down
    case Right
}

protocol GameDelegate {
    func gameover()
    func gameMove()
    func gameMerge()
}

class Game {
    
    /// 格子
    var cells = Array<Cell>()
    /// 总行数
    var row = 5
    /// 总列数
    var column = 5
    /// 当前分数
    var score = 0
    /// 委托
    var delegate: GameDelegate?
    // MARK: 初始化游戏
    func initGame() {
        score = 0
        cells.removeAll()
        for index in 0...row*column-1 {
            let cell = Cell()
            cell.index = index
            cell.row = index/column
            cell.column = index%column
            cells.append(cell)
        }
    }
    
    // MARK: 随机产生一个方块
    func randomCube() {
        // 哪些地方还没有方块
        var indexs = Array<Int>()
        for cell in cells {
            if cell.score == 0 {
                indexs.append(cell.index!)
            }
        }
        // 从这些地方种随机挑选一个
        if indexs.count > 0 {
            let index = Int(arc4random() % UInt32(indexs.count))
            let cell = cells[indexs[index]]
            cell.score = 2
        }
        if isGameover() && delegate != nil {
            delegate?.gameover()
        }
    }
    
    var hasMerge = false
    // TODO: 滑动
    func swipe(direction direction: GameDirection) {
        hasMerge = false
        var moveNum = 0
        while moveNum < column-1 {
            replaceZero(direction: direction)
            moveNum += 1
        }
        merge(direction: direction)
        replaceZero(direction: direction)
        if delegate != nil && !hasMerge {
            delegate?.gameMove()
        }
    }
    
    
    func isGameover() -> Bool {
        if cannotMove(direction: .Up) && cannotMove(direction: .Left) && cannotMove(direction: .Down) && cannotMove(direction: .Right) {
            return true
        }
        return false
    }
    
    func cannotMove(direction direction: GameDirection) -> Bool {
        // 判断
        var num = 0
        for cell in tempCells(direction: direction) {
            if cell.score > 0 {
                switch direction {
                case .Up:
                    if cell.row > 0 {
                        if cells[cell.index-column].score == 0 || cells[cell.index-column].score == cell.score {
                            num += 1
                        }
                    }
                case .Left:
                    if cell.column > 0 {
                        if cells[cell.index-1].score == 0 || cells[cell.index-1].score == cell.score {
                            num += 1
                        }
                    }
                case .Down:
                    if cell.row < row-1 {
                        if cells[cell.index+column].score == 0 || cells[cell.index+column].score == cell.score {
                            num += 1
                        }
                    }
                case .Right:
                    if cell.column < column-1 {
                        if cells[cell.index+1].score == 0 || cells[cell.index+1].score == cell.score {
                            num += 1
                        }
                    }
                }
            }
        }
        if num == 0 {
            return true
        }
        return false
    }
    
    // MARK: 去零
    func replaceZero(direction direction: GameDirection) {
        
        for cell in tempCells(direction: direction) {
            if cell.score > 0 {
                switch direction {
                case .Up:
                    if cell.row > 0 {
                        if cells[cell.index-column].score == 0 {
                            cells[cell.index-column].score = cell.score
                            cell.score = 0
                        }
                    }
                case .Left:
                    if cell.column > 0 {
                        if cells[cell.index-1].score == 0 {
                            cells[cell.index-1].score = cell.score
                            cell.score = 0
                        }
                    }
                case .Down:
                    if cell.row < row-1 {
                        if cells[cell.index+column].score == 0 {
                            cells[cell.index+column].score = cell.score
                            cell.score = 0
                        }
                    }
                case .Right:
                    if cell.column < column-1 {
                        if cells[cell.index+1].score == 0 {
                            cells[cell.index+1].score = cell.score
                            cell.score = 0
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 合并,从中计算分数
    func merge(direction direction: GameDirection) {
        for cell in tempCells(direction: direction) {
            if cell.score > 0 {
                switch direction {
                case .Up:
                    if cell.row > 0 {
                        if cells[cell.index-column].score == cell.score {
                            cells[cell.index-column].score = cell.score * 2
                            score += cell.score * 2
                            cell.score = 0
                            if delegate != nil {
                                delegate?.gameMerge()
                                hasMerge = true
                            }
                        }
                    }
                case .Left:
                    if cell.column > 0 {
                        if cells[cell.index-1].score == cell.score {
                            cells[cell.index-1].score = cell.score * 2
                            score += cell.score * 2
                            cell.score = 0
                            if delegate != nil {
                                delegate?.gameMerge()
                                hasMerge = true
                            }
                        }
                    }
                case .Down:
                    if cell.row < row-1 {
                        if cells[cell.index+column].score == cell.score {
                            cells[cell.index+column].score = cell.score * 2
                            score += cell.score * 2
                            cell.score = 0
                            if delegate != nil {
                                delegate?.gameMerge()
                                hasMerge = true
                            }
                        }
                    }
                case .Right:
                    if cell.column < column-1 {
                        if cells[cell.index+1].score == cell.score {
                            cells[cell.index+1].score = cell.score * 2
                            score += cell.score * 2
                            cell.score = 0
                            if delegate != nil {
                                delegate?.gameMerge()
                                hasMerge = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: 临时数组
    func tempCells (direction direction: GameDirection) -> Array<Cell> {
        var tempCells = Array<Cell>()
        for index in 0...cells.count-1 {
            if direction == .Up || direction == .Left {
                tempCells.append(cells[index])
            } else {
                tempCells.append(cells[cells.count-1-index])
            }
        }
        return tempCells
    }
    
}