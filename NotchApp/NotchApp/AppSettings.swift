import SwiftUI
import Combine

class AppSettings: ObservableObject {
    static let shared = AppSettings()
    
    @Published var waveformColor: Color {
        didSet {
            UserDefaults.standard.set(waveformColor.toHex(), forKey: "waveformColor")
        }
    }
    
    @Published var animationStyle: AnimationStyle {
        didSet {
            UserDefaults.standard.set(animationStyle.rawValue, forKey: "animationStyle")
        }
    }
    
    @Published var expandedHeight: Double {
        didSet {
            UserDefaults.standard.set(expandedHeight, forKey: "expandedHeight")
        }
    }
    
    @Published var expandedWidth: Double {
        didSet {
            UserDefaults.standard.set(expandedWidth, forKey: "expandedWidth")
        }
    }
    
    @Published var launchAtLogin: Bool {
        didSet {
            UserDefaults.standard.set(launchAtLogin, forKey: "launchAtLogin")
        }
    }
    
    private init() {
        let colorHex = UserDefaults.standard.string(forKey: "waveformColor") ?? "#00FF00"
        self.waveformColor = Color(hex: colorHex)
        
        let styleRaw = UserDefaults.standard.string(forKey: "animationStyle") ?? AnimationStyle.bars.rawValue
        self.animationStyle = AnimationStyle(rawValue: styleRaw) ?? .bars
        
        self.expandedHeight = UserDefaults.standard.double(forKey: "expandedHeight") != 0 
            ? UserDefaults.standard.double(forKey: "expandedHeight") 
            : 120.0
        
        self.expandedWidth = UserDefaults.standard.double(forKey: "expandedWidth") != 0 
            ? UserDefaults.standard.double(forKey: "expandedWidth") 
            : 400.0
        
        self.launchAtLogin = UserDefaults.standard.bool(forKey: "launchAtLogin")
    }
}

enum AnimationStyle: String, CaseIterable, Identifiable {
    case bars = "Bars"
    case wave = "Wave"
    case circular = "Circular"
    case pulse = "Pulse"
    
    var id: String { self.rawValue }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 255, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
    
    func toHex() -> String {
        guard let components = NSColor(self).cgColor.components, components.count >= 3 else {
            return "#00FF00"
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        return String(format: "#%02lX%02lX%02lX", 
                     lroundf(r * 255), 
                     lroundf(g * 255), 
                     lroundf(b * 255))
    }
}
