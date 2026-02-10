import SwiftUI

struct WaveformView: View {
    @StateObject private var settings = AppSettings.shared
    @State private var animationPhase: CGFloat = 0
    let isCompact: Bool
    
    private let barCount = 20
    
    var body: some View {
        GeometryReader { geometry in
            switch settings.animationStyle {
            case .bars:
                barsAnimation(geometry: geometry)
            case .wave:
                waveAnimation(geometry: geometry)
            case .circular:
                circularAnimation(geometry: geometry)
            case .pulse:
                pulseAnimation(geometry: geometry)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func barsAnimation(geometry: GeometryProxy) -> some View {
        HStack(spacing: isCompact ? 3 : 5) {
            ForEach(0..<barCount, id: \.self) { index in
                RoundedRectangle(cornerRadius: 2)
                    .fill(settings.waveformColor)
                    .frame(width: isCompact ? 4 : 8)
                    .frame(height: barHeight(for: index, maxHeight: geometry.size.height))
                    .animation(
                        Animation.easeInOut(duration: 0.5)
                            .repeatForever(autoreverses: true)
                            .delay(Double(index) * 0.05),
                        value: animationPhase
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func waveAnimation(geometry: GeometryProxy) -> some View {
        Canvas { context, size in
            let path = Path { path in
                let width = size.width
                let height = size.height
                let midHeight = height / 2
                
                path.move(to: CGPoint(x: 0, y: midHeight))
                
                for x in stride(from: 0, through: width, by: 5) {
                    let relativeX = x / width
                    let sine = sin((relativeX * 4 * .pi) + animationPhase)
                    let y = midHeight + (sine * midHeight * 0.6)
                    path.addLine(to: CGPoint(x: x, y: y))
                }
            }
            
            context.stroke(
                path,
                with: .color(settings.waveformColor),
                lineWidth: isCompact ? 2 : 3
            )
        }
    }
    
    private func circularAnimation(geometry: GeometryProxy) -> some View {
        ZStack {
            ForEach(0..<3, id: \.self) { ring in
                Circle()
                    .stroke(settings.waveformColor.opacity(0.3 + Double(ring) * 0.2), lineWidth: 2)
                    .frame(width: circleSize(for: ring), height: circleSize(for: ring))
                    .scaleEffect(1 + sin(animationPhase + Double(ring) * 0.5) * 0.2)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func pulseAnimation(geometry: GeometryProxy) -> some View {
        Circle()
            .fill(settings.waveformColor)
            .frame(width: isCompact ? 20 : 40, height: isCompact ? 20 : 40)
            .scaleEffect(1 + sin(animationPhase) * 0.3)
            .opacity(0.7 + sin(animationPhase) * 0.3)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private func barHeight(for index: Int, maxHeight: CGFloat) -> CGFloat {
        let normalizedIndex = CGFloat(index) / CGFloat(barCount)
        let sine = sin(normalizedIndex * .pi * 2 + animationPhase)
        let height = (sine + 1) / 2
        return max(maxHeight * 0.2, height * maxHeight)
    }
    
    private func circleSize(for ring: Int) -> CGFloat {
        let baseSize: CGFloat = isCompact ? 15 : 30
        return baseSize + CGFloat(ring) * (isCompact ? 8 : 15)
    }
    
    private func startAnimation() {
        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
            animationPhase = .pi * 2
        }
    }
}
