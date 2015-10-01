
import SpriteKit

public class BitmapFont {
    public var isLoaded:Bool = false {
        didSet(isLoaded) {
            dispatchIsLoaded()
        }
    }
    public var texture:SKTexture?
    public var lineHeight:Int = 0
    private var chars = [Character:BitmapChar]()
    private var loadObservers = [BitmapFontLoadObserver]()
    
    public init(name:String) {
        let loader = BitmapFontLoader(fontName: name + ".xml", textureName: name + ".png", font: self)
        loader.load()
    }
    
    public func addChar(char:BitmapChar) {
        chars[Character(UnicodeScalar(char.id))] = char
    }
    
    public func getChar(id:Character) -> BitmapChar? {
        return chars[id];
    }
    
    public func removeLoadObserver(observer:BitmapFontLoadObserver) {
        var i:Int = 0
        for loadObserver in loadObservers {
            if loadObserver === observer {
                loadObservers.removeAtIndex(i)
                break
            }
            ++i
        }
    }
    
    public func addLoadObserver(observer:BitmapFontLoadObserver) {
        loadObservers.append(observer)
    }
    
    private func dispatchIsLoaded() {
        let observers = loadObservers
        for observer in observers {
            observer.bitmapFontDidLoad()
        }
    }
}
