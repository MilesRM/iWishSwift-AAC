//
//  TextToSpeech.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import AVFoundation

public class TextToSpeech: NSObject {
    
    let synth = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "")
    
    override init() {
        super.init()
        
        do{
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            do{
                try AVAudioSession.sharedInstance().setActive(true)
            }catch{
                
            }
        }catch{
            
        }
    }
    
    func speak(_ text:String) {
        utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5 //朗誦速度
        utterance.pitchMultiplier = 1.0 //音調 0.5-2.0
        utterance.postUtteranceDelay = 0.1 //播放下一句之前有短暫時間的暫停
        utterance.volume = 1 //音量
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        if text != "" {
            synth.speak(utterance)
        }
    }
    
    
}
