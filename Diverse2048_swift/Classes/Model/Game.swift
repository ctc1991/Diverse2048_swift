//
//  Game.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import Foundation

enum GameStatus  {
    case Ready
    case Playing
    case Finished
}

enum GameDirection {
    case Up
    case Left
    case Down
    case Right
}

class Game {
    
    var status = GameStatus.Ready
    var cells = Array<Cell>()
    /// 总行数
    var row = 4
    /// 总列数
    var column = 4
    
    // MARK: 初始化游戏
    func initGame() {
        status = .Ready
        cells.removeAll()
        for index in 0...15 {
            let cell = Cell()
            cell.index = index
            cell.row = index/4
            cell.column = index%4
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
    }
    
    // TODO: 滑动
    func swipe(direction direction: GameDirection) {
        var moveNum = 0
        while moveNum < column-1 {
            replaceZero(direction: direction)
            moveNum += 1
        }
        merge(direction: direction)
        replaceZero(direction: direction)
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
    
    // MARK: 合并
    func merge(direction direction: GameDirection) {
        for cell in tempCells(direction: direction) {
            if cell.score > 0 {
                switch direction {
                case .Up:
                    if cell.row > 0 {
                        if cells[cell.index-column].score == cell.score {
                            cells[cell.index-column].score = cell.score * 2
                            cell.score = 0
                        }
                    }
                case .Left:
                    if cell.column > 0 {
                        if cells[cell.index-1].score == cell.score {
                            cells[cell.index-1].score = cell.score * 2
                            cell.score = 0
                        }
                    }
                case .Down:
                    if cell.row < row-1 {
                        if cells[cell.index+column].score == cell.score {
                            cells[cell.index+column].score = cell.score * 2
                            cell.score = 0
                        }
                    }
                case .Right:
                    if cell.column < column-1 {
                        if cells[cell.index+1].score == cell.score {
                            cells[cell.index+1].score = cell.score * 2
                            cell.score = 0
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