//
//  Cell.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/12.
//  Copyright © 2016年 ctc. All rights reserved.
//

import Foundation

enum CellType {
    case Default
}

class Cell: CustomStringConvertible {
    
    /// 在数组中的位置
    var index: Int!
    /// 分数
    var score = 0
    /// 所在行数
    var row: Int!
    /// 所在列树
    var column: Int!
    
    var description: String {
        let str = String(format: "%d", score)
        return str
    }
    
}