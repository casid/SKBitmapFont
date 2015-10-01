import SpriteKit

public enum BitmapLabelHorizontalAlignment:Int {
    case Left
    case Center
    case Right
}

public enum BitmapLabelVerticalAlignment:Int {
    case Top
    case Center
    case Bottom
}

public class BitmapLabel : SKNode, BitmapFontLoadObserver {
    private let font:BitmapFont
    private var letters = [SKSpriteNode]()
    
    public var text:String {
        didSet(text) {
            layout()
        }
    }
    public var horizontalAlignment:BitmapLabelHorizontalAlignment {
        didSet {
            layout()
        }
    }
    public var verticalAlignment:BitmapLabelVerticalAlignment {
        didSet {
            layout()
        }
    }
    
    public init(font:BitmapFont) {
        self.font = font
        self.text = ""
        self.horizontalAlignment = BitmapLabelHorizontalAlignment.Left
        self.verticalAlignment = BitmapLabelVerticalAlignment.Top
        
        super.init()
        
        if !font.isLoaded {
            font.addLoadObserver(self)
        }
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        self.removeAllChildren()
        letters.removeAll()
        
        if font.isLoaded {
            
            var x:CGFloat = 0
            var y:CGFloat = 0
            var lineIndex:Int = 0
            var index:Int = 0
            let anchorPointY:CGFloat = getLetterAnchorPointY()
            
            for character in text.characters {
                if let char = font.getChar(character) {
                    let sprite = SKSpriteNode(texture: char.texture)
                    sprite.anchorPoint.x = 0
                    sprite.anchorPoint.y = anchorPointY
                    sprite.position.x = x + CGFloat(char.xOffset)
                    sprite.position.y = y - anchorPointY * CGFloat(char.yOffset)
                    addChild(sprite)
                    letters.append(sprite)
                    
                    x += CGFloat(char.xAdvance)
                    ++index
                } else {
                    if character == "\n" {
                        applyHorizontalAlignment(lineIndex, toIndex: index - 1, lineWidth: x)
                        
                        x = 0
                        y -= CGFloat(font.lineHeight)
                        lineIndex = index
                    }
                }
            }
            
            if x != 0 {
                applyHorizontalAlignment(lineIndex, toIndex: index - 1, lineWidth: x)
            }
            
            applyVerticalAlignment()
        }
    }
    
    private func getLetterAnchorPointY() -> CGFloat {
        if verticalAlignment == BitmapLabelVerticalAlignment.Bottom {
            return 0
        } else if verticalAlignment == BitmapLabelVerticalAlignment.Center {
            return 0.5
        }
        
        return 1
    }
    
    private func applyHorizontalAlignment(fromIndex:Int, toIndex:Int, lineWidth:CGFloat) {
        var offset:CGFloat = 0
        if horizontalAlignment == BitmapLabelHorizontalAlignment.Right {
            offset = -lineWidth
        } else if horizontalAlignment == BitmapLabelHorizontalAlignment.Center {
            offset = -0.5 * lineWidth
        }
        
        if offset != 0 {
            for var index = fromIndex; index <= toIndex; ++index {
                letters[index].position.x += offset
            }
        }
    }
    
    private func applyVerticalAlignment() {
        if verticalAlignment == BitmapLabelVerticalAlignment.Top {
            return
        }
        
        var offset:CGFloat = 0
        var minY:CGFloat = CGFloat.max
        var maxY:CGFloat = CGFloat.min
        
        for letter in letters {
            minY = min(letter.position.y - (1 - letter.anchorPoint.y) * letter.size.height, minY)
            maxY = max(letter.position.y + letter.anchorPoint.y * letter.size.height, maxY)
        }
        
        let delta = maxY - minY
        if verticalAlignment == BitmapLabelVerticalAlignment.Bottom {
            offset = delta
        } else if verticalAlignment == BitmapLabelVerticalAlignment.Center {
            offset = 0.5 * delta
        }
        
        if offset != 0 {
            for letter in letters {
                letter.position.y += offset
            }
        }
    }
    
    public func bitmapFontDidLoad() {
        font.removeLoadObserver(self)
        layout()
    }
}
