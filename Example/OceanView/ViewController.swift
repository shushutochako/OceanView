//
//  ViewController.swift
//  OceanView
//
//  Created by shushutochako on 10/27/2015.
//  Copyright (c) 2015 shushutochako. All rights reserved.
//

import UIKit
import OceanView

class ViewController: UIViewController {

    @IBOutlet weak var frontWaveView: OceanView! {
        didSet {
            self.frontWaveView.alpha = 0.5
            self.frontWaveView.frequency = 1
            self.frontWaveView.waveColor = UIColor(red: 127/255, green: 171/255, blue: 255/255, alpha: 1)
            self.frontWaveView.amplitudeRate = 0.2
            self.frontWaveView.update(0)
        }
    }
    @IBOutlet weak var rearWaveView: OceanView! {
        didSet {
            self.rearWaveView.frequency = 2
            self.rearWaveView.waveColor = UIColor(red: 79/255, green: 119/255, blue: 180/255, alpha: 1)
            self.rearWaveView.amplitudeRate = 0.2
            self.rearWaveView.update(0)
        }
    }
    @IBOutlet weak var moveButton: UIButton! {
        didSet {
            let longPress = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
            longPress.minimumPressDuration = 0.2
            self.moveButton.addGestureRecognizer(longPress)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func updateWave() {
        self.rearWaveView.update(5)
        self.frontWaveView.update(3)
        self.performSelector(Selector("longPress:"), withObject: nil, afterDelay: 0.02)
    }
    
    func longPress(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .Began:
            self.updateWave()
        case .Changed:
            break
        case .Ended:
            self.rearWaveView.update(0)
            self.frontWaveView.update(0)
            NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: Selector("longPress:"), object: nil)
        default:
            self.updateWave()
        }
    }
}

