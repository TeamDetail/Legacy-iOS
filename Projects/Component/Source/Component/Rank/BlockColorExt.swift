import SwiftUI

//TODO: 수정해야함
func blockColor(for blocks: Int?) -> Color {
    guard let blocks = blocks else { return Color(0xA05AE8) }
    
    if blocks > 2000 {
        return Color(0xA05AE8)
    }
    
    let normalized = blocks % 1000
    
    switch normalized {
    case 0..<200:
        return (blocks < 1001 ? Color(0xA05AE8) : Color(0xEDB900)).opacity(0.6)
    case 200..<400:
        return Color(0xA05AE8).opacity(0.7)
    case 400..<600:
        return Color(0xA05AE8).opacity(0.8)
    case 600..<800:
        return Color(0xA05AE8).opacity(0.9)
    default:
        return Color(0xA05AE8)
    }
}

