//
//  GameVc.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/16.
//  Copyright © 2016年 ctc. All rights reserved.
//

import UIKit

class GameVc: ViewController {
    
    var game = Game()

    @IBOutlet weak var gameView: UIView!
    var cubes = Array<CubeView>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        if GameManager.load(.Default).count == 0 {
            game.initGame()
            game.randomCube()
            game.randomCube()
        } else {
            game = GameManager.load(.Default).last!
        }
        createSwipeGestureRecognizer()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        initGameView()
        updateGameUI()
    }
    
    func initUI() {
        
    }
    
    func initGameView() {
        let spacing = CGFloat(4)
        let cubeWidth = (gameView.frame.width - CGFloat(game.column+1)*spacing)/CGFloat(game.column)
        
        let cubeHeight = (gameView.frame.height - CGFloat(game.row+1)*spacing)/CGFloat(game.row)
        
        for i in 0...(game.column*game.row-1) {
            let x = CGFloat(4) + CGFloat(i%game.column) * (cubeWidth + CGFloat(4));
            let y = CGFloat(4) + CGFloat(i/game.column) * (cubeHeight + CGFloat(4));
            let frame = CGRect(x: x, y: y, width: cubeWidth, height: cubeHeight)
            let cube = CubeView(frame: frame)
            cube.layer.cornerRadius = 5.0
            cube.layer.masksToBounds = true
            cube.layer.borderWidth = 1.0
            gameView.addSubview(cube)
            cubes.append(cube)
        }
    }
    
    func updateGameUI() {
        for index in 0...game.cells.count-1 {
            if game.cells[index].score == 0 {
                cubes[index].text = ""
            } else {
                cubes[index].text = String(format: "%d", game.cells[index].score)
            }
            cubes[index].backgroundColor = cubes[index].colors[root(game.cells[index].score)]
            cubes[index].layer.borderColor = cubes[index].colors[root(game.cells[index].score)].CGColor
        }
    }
 
    // MARK: 求2的几次幂
    func root(score: Int) -> Int {
        var num = 0
        var s = Int(score)
        while s%2 == 0 && s != 0 {
            num += 1
            s = s/2
        }
        return num
    }
    
    /**
     添加手势
     */
    func createSwipeGestureRecognizer() {
        let swpieForBackgroundUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundUp.direction = .Up
        view.addGestureRecognizer(swpieForBackgroundUp)
        
        let swpieForBackgroundLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundLeft.direction = .Left
        view.addGestureRecognizer(swpieForBackgroundLeft)
        
        let swpieForBackgroundDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundDown.direction = .Down
        view.addGestureRecognizer(swpieForBackgroundDown)
        
        let swpieForBackgroundRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction))
        swpieForBackgroundRight.direction = .Right
        view.addGestureRecognizer(swpieForBackgroundRight)
    }
    
    /**
     手势方法
     
     - parameter sender: 手势对象
     */
    func swipeAction(sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case UISwipeGestureRecognizerDirection.Up:
            if !game.cannotMove(direction: .Up) {
                game.swipe(direction: .Up)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Left:
            if !game.cannotMove(direction: .Left) {
                game.swipe(direction: .Left)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Down:
            if !game.cannotMove(direction: .Down) {
                game.swipe(direction: .Down)
                game.randomCube()
            }
        case UISwipeGestureRecognizerDirection.Right:
            if !game.cannotMove(direction: .Right) {
                game.swipe(direction: .Right)
                game.randomCube()
            }
        default:
            break
        }
        updateGameUI()
    }

    @IBAction func backHome(sender: UIButton) {
        GameManager.save(game: game, type: .Default)
        dismissViewControllerAnimated(true, completion: nil)
    }

}
