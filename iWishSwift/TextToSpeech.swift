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
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.2
        utterance.postUtteranceDelay = 0.1
        utterance.volume = 1
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-TW")
        if text != "" {
            synth.speak(utterance)
        }
    }
    
    
}
