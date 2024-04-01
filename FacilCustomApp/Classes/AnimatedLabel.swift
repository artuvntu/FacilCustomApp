//
//  AnimatedLabel.swift
//  Cuenta Puntos
//
//  Created by Arturo Ventura on 11/12/22.
//

import UIKit

open class AnimatedLabelWeakWrapper: NSObject {
    weak var label: AnimatedLabel?
    init(label: AnimatedLabel) {
        super.init()
        self.label = label
    }
    
    func tickInitial() {
        label?.tickInitial()
    }
    
    func tickMorphing() {
        label?.tickMorphing()
    }
    
}

open class AnimatedLabel: UILabel {
    
    private(set) var targetText: String?
    var animationDuration: CGFloat = 0.1
    var characterAnimationOffset: CGFloat = 0
    var characterShrinkFactor: CGFloat = 0
    var morphingEnabled = false

    private(set) var numberOfAttributionStages: UInt = 0;
    var _attributionStages: Array<Dictionary<NSAttributedString.Key,Any>>?
    var attributionStages: Array<Dictionary<NSAttributedString.Key,Any>>? {
        get {
            if self._attributionStages == nil {
                var attributionStages = Array<Dictionary<NSAttributedString.Key,Any>>()
                let minFontSize: CGFloat = self.font.pointSize / self.characterShrinkFactor;
                let fontRatio: CGFloat = minFontSize / self.font.pointSize;
                let fontPadding: CGFloat = 1 - fontRatio;
                var progress, fontScale: CGFloat;
                var color: UIColor;
                for i in 0..<numberOfAttributionStages {
                    var attributionStage = Dictionary<NSAttributedString.Key,Any>()
                    progress = self.easedValue(p: CGFloat(i/(numberOfAttributionStages - 1)))
                    color = self.textColorWithAlpha(alpha: progress)
                    attributionStage[NSAttributedString.Key.foregroundColor] = color
                    fontScale = fontRatio + progress * fontPadding
                    attributionStage[NSAttributedString.Key.font] = self.fontForScale(scale:fontScale)
                    attributionStage[NSAttributedString.Key.KernFactorAttributeName] = 1-progress
                    attributionStages.append(attributionStage)
                }
                _attributionStages = attributionStages
            }
            return _attributionStages
        }
        set {
            self._attributionStages = newValue
        }
    }
    var animating = true;

    var attributionStage: Int = 0;
    var deletionRanges: Array<Any> = [];
    var additionRanges: Array<Any> = [];
    var nextText: String?

    var displayLink: CADisplayLink?
    var displayLinkDuration: CFTimeInterval!

    let serialQueue = DispatchQueue(label: "com.vapps.AnimatedLabel")
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        designatedInitialization()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        designatedInitialization()
    }
    
    func designatedInitialization() {
        displayLinkDuration = -1
        morphingEnabled = true
        animating = true
        
        setupDisplayLinkWithSelector(selector: #selector(tickInitial))
        
        animationDuration = 0.37
        characterAnimationOffset = 0.25
        characterShrinkFactor = 4
    }
    
    deinit {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    func numberOfAttributionStagesShouldChange() {
        if displayLinkDuration > 0 {
            numberOfAttributionStages = UInt((1/displayLinkDuration) * animationDuration)
            attributionStages = nil
            if nextText != nil {
                beginMorphing()
            }
        }
    }
    
    open override var textColor: UIColor! {
        didSet {
            serialQueue.sync {
                self.attributionStages = self.attributionStages?.map({ attributionStageOld in
                    var attributionStage = attributionStageOld
                    if let color = attributionStage[NSAttributedString.Key.foregroundColor] as? UIColor {
                        attributionStage[.foregroundColor] = self.textColorWithAlpha(alpha:color.cgColor.alpha)
                    }
                    return attributionStage
                })
            }
        }
    }
    
    func setTextWithoutMorphing(_ text: String) {
        let wasMorpthingEnabled = morphingEnabled
        self.morphingEnabled = false
        self.text = text
        self.morphingEnabled = wasMorpthingEnabled
    }
    
    func setDisplayLinkDuration(displayLinkDuration: CFTimeInterval) {
        self.displayLinkDuration = displayLinkDuration
        self.numberOfAttributionStagesShouldChange()
    }
    
    func setAnimationDuration(animationDuration: CGFloat) {
        if !self.animating {
            self.animationDuration = animationDuration
            self.numberOfAttributionStagesShouldChange()
        }
    }
    
    @objc func tickInitial() {
        if self.displayLinkDuration <= 0 {
            self.displayLink?.isPaused = true
            let duration = self.displayLink?.duration
            self.setupDisplayLinkWithSelector(selector: #selector(tickMorphing))
            self.displayLink?.isPaused = true
            self.displayLinkDuration = duration
        }
    }
    
    func setupDisplayLinkWithSelector(selector: Selector) {
        let displayLinkTarget = AnimatedLabelWeakWrapper(label: self)
        let displayLink = CADisplayLink(target: displayLinkTarget, selector: selector)
        displayLink.add(to: .current, forMode: .common)
        self.displayLink?.invalidate()
        self.displayLink = displayLink
    }
    
    func shouldAnimateSettingText() -> Bool {
        self.morphingEnabled && UIView.areAnimationsEnabled
    }
    
    func easedValue(p: CGFloat) -> CGFloat {
        if (p < 0.5) {
            return 2 * p * p
        }
        return (-2 * p * p) + (4 * p) - 1
    }
    
    func textColorWithAlpha(alpha: CGFloat) -> UIColor {
        textColor.withAlphaComponent(alpha)
    }
    
    func fontForScale(scale: CGFloat) -> UIFont {
        UIFont(name: self.font.fontName, size: self.font.pointSize * scale)!
    }
    
    func scalarRangesInArrayOfRanges(ranges: [NSValue]) -> [NSValue] {
        var scalarRanges = [NSValue]()
        for value in ranges {
            let range = value.rangeValue
            if range.length > 1 {
                scalarRanges.append(contentsOf: (0..<range.length).map({NSValue(range: NSRange(location: range.location + $0, length: 1))}))
            } else {
                scalarRanges.append(value)
            }
        }
        return scalarRanges
    }
    
    @objc func tickMorphing() {
        
    }
    

    
    func beginMorphing() {
        
    }
    

    
    func setText(_ text: String, withCompletionBlock: (()->Void)?) {
        
    }
    

}

extension NSAttributedString.Key {
    static let KernFactorAttributeName: NSAttributedString.Key = .init("KernFactorAttributeName")
}
