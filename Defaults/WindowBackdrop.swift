import SwiftUI

struct WindowBackdrop: View {
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.clear
                HalftoneTexture(
                    color: colorScheme == .dark
                        ? Color(hex: 0xF6E9CB, alpha: 0.06)
                        : Color(hex: 0x33304A, alpha: 0.05)
                )
            }
        }
        .ignoresSafeArea()
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