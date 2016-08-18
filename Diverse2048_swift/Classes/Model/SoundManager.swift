//
//  SoundManager.swift
//  Diverse2048_swift
//
//  Created by Tech on 16/8/18.
//  Copyright © 2016年 ctc. All rights reserved.
//

import Foundation
import AudioToolbox

let soundManager = SoundManager()

class SoundManager {
    
    var moveSound: SystemSoundID?
    var mergeSound: SystemSoundID?
    
    func initSound() {
        let moveSoundPath = NSBundle.mainBundle().pathForResource("move", ofType: "wav")
        var moveSound = SystemSoundID()
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: moveSoundPath!), &moveSound)
        self.moveSound = moveSound
        
        let mergeSoundPath = NSBundle.mainBundle().pathForResource("merge", ofType: "wav")
        var mergeSound = SystemSoundID()
        AudioServicesCreateSystemSoundID(NSURL(fileURLWithPath: mergeSoundPath!), &mergeSound)
        self.mergeSound = mergeSound
    }
    
    func play(sound sound: SystemSoundID) {
        AudioServicesPlaySystemSound(sound)
    }
    
}