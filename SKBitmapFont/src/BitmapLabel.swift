import SpriteKit

public class BitmapLabel : SKNode, BitmapFontLoadObserver {
    private let font:BitmapFont
    public var text:String {
        didSet(text) {
            layout()
        }
    }
    
    public init(font:BitmapFont) {
        self.font = font
        self.text = ""
        
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
        
        if font.isLoaded {
            
            var x:CGFloat = 0
            var y:CGFloat = 0
            
            for character in text.characters {
                if let char = font.getChar(character) {
                    let sprite = SKSpriteNode(texture: char.texture)
                    sprite.anchorPoint.x = 0
                    sprite.anchorPoint.y = 1
                    sprite.position.x = x + CGFloat(char.xOffset)
                    sprite.position.y = y - CGFloat(char.yOffset)
                    addChild(sprite)
                    
                    x += CGFloat(char.xAdvance)
                } else {
                    if character == "\n" {
                        x = 0
                        y -= CGFloat(font.lineHeight)
                    }
                }
            }
        }
    }
    
    public func bitmapFontDidLoad() {
        font.removeLoadObserver(self)
        layout()
    }
}
