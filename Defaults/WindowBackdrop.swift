import SwiftUI

struct WindowBackdrop: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                LinearGradient(
                    stops: [
                        .init(color: Color(hex: 0xF2E2BD), location: 0),
                        .init(color: Color(hex: 0xF8EED8), location: 0.55),
                        .init(color: Color(hex: 0xF3E6C6), location: 1)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                blob(Color(hex: 0xC8674A, alpha: 0.38), diameter: 460)
                    .position(x: 150, y: 330)
                blob(Color(hex: 0xD99A4E, alpha: 0.40), diameter: 420)
                    .position(x: geo.size.width - 150, y: 130)
                blob(Color(hex: 0x6FA287, alpha: 0.35), diameter: 480)
                    .position(x: geo.size.width - 500, y: geo.size.height - 120)
                HalftoneTexture()
            }
        }
        .ignoresSafeArea()
    }
    
    private func blob(_ color: Color, diameter: CGFloat) -> some View {
        RadialGradient(colors: [color, .clear], center: .center, startRadius: 0, endRadius: diameter / 2)
            .frame(width: diameter, height: diameter)
    }
}

struct HalftoneTexture: View {
    var color: Color = Color(hex: 0x33304A, alpha: 0.05)
    var step: CGFloat = 9
    var dot: CGFloat = 2
    
    var body: some View {
        Canvas { ctx, size in
            let start = (step - 1) / 2
            var dotY = start
            while dotY < size.height {
                var dotX = start
                while dotX < size.width {
                    ctx.fill(
                        Path(ellipseIn: CGRect(x: dotX, y: dotY, width: dot, height: dot)),
                        with: .color(color)
                    )
                    dotX += step
                }
                dotY += step
            }
        }
        .allowsHitTesting(false)
    }
}

extension Color {
    init(hex: UInt32, alpha: CGFloat = 1) {
        let r = CGFloat((hex >> 16) & 0xFF) / 255.0
        let g = CGFloat((hex >> 8) & 0xFF) / 255.0
        let b = CGFloat(hex & 0xFF) / 255.0
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}