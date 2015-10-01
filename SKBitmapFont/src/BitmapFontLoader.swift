
import SpriteKit

public class BitmapFontLoader : NSObject, NSXMLParserDelegate {
    let fontName:String
    let textureName:String
    let font:BitmapFont
    
    public init(fontName:String, textureName:String, font:BitmapFont) {
        self.fontName = fontName
        self.textureName = textureName
        self.font = font
        
        super.init()
    }
    
    public func load() {
        loadTexture()
    }
    
    private func loadTexture() {
        let texture = SKTexture(imageNamed: textureName)
        font.texture = texture
        
        texture.preloadWithCompletionHandler { () -> Void in
            self.loadFont()
        }
    }
    
    private func loadFont() {
        if let path = NSBundle.mainBundle().pathForResource(fontName, ofType: nil) {
            if let data = NSData(contentsOfFile: path) {
                let parser = NSXMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }
        
        font.isLoaded = true
    }
    
    public func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "char" {
            let char = parseChar(attributeDict)
            font.addChar(char)
        } else if elementName == "common" {
            font.lineHeight = parseInt(attributeDict["lineHeight"])
        }
    }
    
    private func parseChar(attributes: [String : String]) -> BitmapChar {
        let char = BitmapChar()
        char.id = parseInt(attributes["id"])
        char.x = parseInt(attributes["x"])
        char.y = parseInt(attributes["y"])
        char.width = parseInt(attributes["width"])
        char.height = parseInt(attributes["height"])
        char.xOffset = parseInt(attributes["xoffset"])
        char.yOffset = parseInt(attributes["yoffset"])
        char.xAdvance = parseInt(attributes["xadvance"])
        
        let size = font.texture!.size()
        let rect = CGRect(x: CGFloat(char.x) / size.width,
                          y: 1 - CGFloat(char.y + char.height) / size.height,
                          width: CGFloat(char.width) / size.width,
                          height: CGFloat(char.height) / size.height)
        
        char.texture = SKTexture(rect: rect, inTexture: font.texture!)
        
        return char
    }
    
    private func parseInt(value:String?) -> Int {
        if value != nil {
            let integerValue = Int(value!)
            if integerValue != nil {
                return integerValue!
            }
        }
        
        return 0
    }
}
