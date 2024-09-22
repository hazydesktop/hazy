import Foundation
import Glibc
import CGtk
import CNotify

class Widget {
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    
    init(x: Int, y: Int, width: Int, height: Int) {
        self.x = x
        self.y = y
        self.width = width
        self.height = height
    }
    
    func draw() {
        // Overridden by subclasses to draw content
    }
}
