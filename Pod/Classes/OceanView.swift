//
//  OceanView.swift
//
//  Created by shushutochako on 10/22/15.
//  Inspired by SCSiriWaveformView in stefanceriu
//  https://github.com/stefanceriu/SCSiriWaveformView
//
//  Copyright (c) 2015 shushutochako. All rights reserved.
//

import UIKit

public class OceanView: UIView {
    
    public var waveColor = UIColor()
    public var idleAmplitude: CGFloat = 0.01
    public var frequency: CGFloat = 1.5
    public var density: CGFloat = 5.0
    public var phaseShift: CGFloat = -0.15
    public var amplitudeRate: CGFloat = 1.0
    
    private var phase: CGFloat = 0
    private var amplitude: CGFloat = 1.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.waveColor = UIColor.whiteColor()
    }
    
    public func update(level: CGFloat) {
        // To clear so that it does not overflow
        if self.phase < -200 {
            self.phase = 0
        }
        self.phase += self.phaseShift
        
        if level < self.idleAmplitude {
            self.amplitude = self.idleAmplitude
        } else {
            self.amplitude = min(1,level * self.amplitudeRate)
        }
        self.setNeedsDisplay()
    }
    
    override public func drawRect(rect: CGRect) {
        var context = UIGraphicsGetCurrentContext()
        CGContextClearRect(context, self.bounds)
        
        self.backgroundColor?.set()
        CGContextFillRect(context, rect)
        
        context = UIGraphicsGetCurrentContext()
        
        let halfHeight = CGRectGetHeight(self.bounds) / 2
        let width = CGRectGetWidth(self.bounds)
        let mid = width / 2
        
        let maxAmplitude = halfHeight
        self.waveColor.colorWithAlphaComponent(CGColorGetAlpha(self.waveColor.CGColor)).set()
        
        let drawingWidth = width + self.density
        for var x: CGFloat = 0; x < drawingWidth; x += self.density {
            // set so that the wave is maximum in the middle of the view
            let scaling: CGFloat = -pow(1 / mid * (x - mid), 2) + 1
            let amplitude = scaling * maxAmplitude * self.amplitude
            let cycle = Float(CGFloat(2 * M_PI) * (x / width) * self.frequency + self.phase)
            
            let y = amplitude * CGFloat(sinf(cycle)) + halfHeight
            if x == 0 {
                // point of start
                CGContextMoveToPoint(context, x, y);
            } else {
                CGContextAddLineToPoint(context, x, y);
            }
        }
        CGContextAddLineToPoint(context, self.frame.size.width, halfHeight)
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height)
        CGContextAddLineToPoint(context, 0, self.frame.size.height)
        CGContextAddLineToPoint(context, 0, halfHeight)
        
        CGContextFillPath(context);
    }
}