#!/usr/bin/env swift
//
//  GenerateAppIcon.swift
//  Defaults
//
//  Regenerates every PNG in Defaults/Assets.xcassets/AppIcon.appiconset.
//
//  Why this exists: the icon artwork that was committed was white-on-white
//  (average luminance ~0.87, darkest pixel ~0.60), so macOS rendered it as a
//  blank white square both in the Dock and in the app's own info bar.
//
//  The mark follows Apple's macOS icon grid — an 824pt rounded square centred
//  in a 1024pt canvas with a soft drop shadow — and uses a slate gradient with
//  a white monospaced terminal prompt, matching the app's black-and-white
//  terminal button.
//
//  Usage:  swift Tools/GenerateAppIcon.swift
//
//  Tweak the Palette / Layout values below and re-run to restyle the icon; the
//  macOS sizes are drawn as a rounded tile, the (unused) iOS sizes full-bleed.
//

import CoreGraphics
import Foundation
import ImageIO
import UniformTypeIdentifiers

// MARK: - Design

enum Palette {
    /// Slate blue at the top of the tile.
    static let top = CGColor(srgbRed: 0.431, green: 0.478, blue: 0.561, alpha: 1)
    /// Deep slate at the bottom of the tile.
    static let bottom = CGColor(srgbRed: 0.118, green: 0.145, blue: 0.188, alpha: 1)
    /// The prompt glyph.
    static let ink = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 1)
    /// Glossy sheen over the top half.
    static let sheen = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0.10)
    /// Hairline just inside the tile edge, so the silhouette reads on dark backgrounds.
    static let edge = CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0.16)
    static let shadow = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.35)
}

enum Layout {
    static let canvas: CGFloat = 1024
    /// Inset of the tile inside the canvas (Apple's macOS grid uses 100pt).
    static let tileInset: CGFloat = 100
    /// Corner radius as a fraction of the tile width (Apple uses ~0.225).
    static let cornerRadiusRatio: CGFloat = 0.225
    /// Prompt stroke weight as a fraction of the tile width.
    static let strokeRatio: CGFloat = 0.10
}

// MARK: - Rendering

/// Renders the icon at 1024pt. `fullBleed` draws a square, corner-less tile for
/// the iOS entries (which the OS masks itself).
func makeMaster(fullBleed: Bool) -> CGImage {
    let size = Layout.canvas
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
        data: nil,
        width: Int(size),
        height: Int(size),
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: space,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )!

    context.setAllowsAntialiasing(true)
    context.interpolationQuality = .high

    let inset = fullBleed ? 0 : Layout.tileInset
    let tile = CGRect(x: inset, y: inset, width: size - inset * 2, height: size - inset * 2)
    let radius = fullBleed ? 0 : tile.width * Layout.cornerRadiusRatio
    let tilePath = CGPath(roundedRect: tile, cornerWidth: radius, cornerHeight: radius, transform: nil)

    // Drop shadow: filled first with the darkest colour so the shadow is
    // cast, then painted over by the gradient below.
    if !fullBleed {
        context.saveGState()
        context.setShadow(offset: CGSize(width: 0, height: -14), blur: 28, color: Palette.shadow)
        context.addPath(tilePath)
        context.setFillColor(Palette.bottom)
        context.fillPath()
        context.restoreGState()
    }

    // Gradient body + sheen, clipped to the tile.
    context.saveGState()
    context.addPath(tilePath)
    context.clip()

    let bodyGradient = CGGradient(
        colorsSpace: space,
        colors: [Palette.bottom, Palette.top] as CFArray,
        locations: [0, 1]
    )!
    context.drawLinearGradient(
        bodyGradient,
        start: CGPoint(x: 0, y: inset),
        end: CGPoint(x: 0, y: size - inset),
        options: []
    )

    let sheenGradient = CGGradient(
        colorsSpace: space,
        colors: [Palette.sheen, CGColor(srgbRed: 1, green: 1, blue: 1, alpha: 0)] as CFArray,
        locations: [0, 1]
    )!
    context.drawLinearGradient(
        sheenGradient,
        start: CGPoint(x: 0, y: size),
        end: CGPoint(x: 0, y: size * 0.45),
        options: []
    )
    context.restoreGState()

    // Prompt glyph: ">" then a rounded underscore bar.
    let tileWidth = tile.width
    let tileMinX = inset
    let tileMinY = inset
    let stroke = tileWidth * Layout.strokeRatio

    func point(_ x: CGFloat, _ y: CGFloat) -> CGPoint {
        CGPoint(x: tileMinX + x * tileWidth, y: tileMinY + y * tileWidth)
    }

    context.saveGState()
    context.setLineWidth(stroke)
    context.setLineCap(.round)
    context.setLineJoin(.round)
    context.setStrokeColor(Palette.ink)
    context.setFillColor(Palette.ink)
    context.setShadow(
        offset: CGSize(width: 0, height: -6),
        blur: 14,
        color: CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 0.30)
    )

    context.beginPath()
    context.move(to: point(0.300, 0.600))
    context.addLine(to: point(0.455, 0.500))
    context.addLine(to: point(0.300, 0.400))
    context.strokePath()

    let bar = CGRect(
        x: tileMinX + 0.545 * tileWidth,
        y: tileMinY + 0.400 * tileWidth,
        width: 0.190 * tileWidth,
        height: stroke
    )
    context.addPath(
        CGPath(roundedRect: bar, cornerWidth: stroke / 2, cornerHeight: stroke / 2, transform: nil)
    )
    context.fillPath()
    context.restoreGState()

    // Inner hairline. Clipped to the tile and inset by half the stroke width so
    // it hugs the inside of the silhouette instead of spilling outside it.
    if !fullBleed {
        let lineWidth: CGFloat = 3
        let edgeInset = Layout.tileInset + lineWidth / 2
        let edgePath = CGPath(
            roundedRect: CGRect(
                x: edgeInset,
                y: edgeInset,
                width: size - edgeInset * 2,
                height: size - edgeInset * 2
            ),
            cornerWidth: radius - lineWidth / 2,
            cornerHeight: radius - lineWidth / 2,
            transform: nil
        )
        context.saveGState()
        context.addPath(tilePath)
        context.clip()
        context.addPath(edgePath)
        context.setStrokeColor(Palette.edge)
        context.setLineWidth(lineWidth)
        context.strokePath()
        context.restoreGState()
    }

    return context.makeImage()!
}

/// Downsamples the master to `size` and writes an 8-bit sRGB PNG.
func writePNG(_ master: CGImage, size: Int, to url: URL) {
    let space = CGColorSpace(name: CGColorSpace.sRGB)!
    let context = CGContext(
        data: nil,
        width: size,
        height: size,
        bitsPerComponent: 8,
        bytesPerRow: 0,
        space: space,
        bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
    )!
    context.interpolationQuality = .high
    context.draw(master, in: CGRect(x: 0, y: 0, width: size, height: size))

    guard let image = context.makeImage(),
          let destination = CGImageDestinationCreateWithURL(
            url as CFURL, UTType.png.identifier as CFString, 1, nil
          ) else {
        FileHandle.standardError.write("failed to encode \(url.lastPathComponent)\n".data(using: .utf8)!)
        return
    }

    CGImageDestinationAddImage(destination, image, nil)
    if !CGImageDestinationFinalize(destination) {
        FileHandle.standardError.write("failed to write \(url.lastPathComponent)\n".data(using: .utf8)!)
    }
}

// MARK: - Sizes

/// Every filename in AppIcon.appiconset and its pixel size, mirroring the
/// existing Contents.json. macOS entries get the rounded tile; the iOS entries
/// (unused by this macOS-only app) are drawn full-bleed.
let macSizes: [(String, Int)] = [
    ("mac16.png", 16),
    ("mac32.png", 32),
    ("mac64.png", 64),
    ("mac128.png", 128),
    ("mac256.png", 256),
    ("mac512.png", 512),
    ("mac1024.png", 1024)
]

let iosSizes: [(String, Int)] = [
    ("notification40.png", 40),
    ("notification60.png", 60),
    ("settings58.png", 58),
    ("settings87.png", 87),
    ("spotlight80.png", 80),
    ("spotlight120.png", 120),
    ("iphone120.png", 120),
    ("iphone180.png", 180),
    ("ipadNotification20.png", 20),
    ("ipadNotification40.png", 40),
    ("ipadSettings29.png", 29),
    ("ipadSettings58.png", 58),
    ("ipadSpotlight40.png", 40),
    ("ipadSpotlight80.png", 80),
    ("ipad76.png", 76),
    ("ipad152.png", 152),
    ("ipadPro167.png", 167),
    ("appstore1024.png", 1024)
]

// MARK: - Entry point

let setPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    .appendingPathComponent("Defaults/Assets.xcassets/AppIcon.appiconset")

guard FileManager.default.fileExists(atPath: setPath.path) else {
    FileHandle.standardError.write("run this from the repository root\n".data(using: .utf8)!)
    exit(1)
}

let macMaster = makeMaster(fullBleed: false)
let iosMaster = makeMaster(fullBleed: true)

var written = 0
for (name, size) in macSizes {
    writePNG(macMaster, size: size, to: setPath.appendingPathComponent(name))
    written += 1
}
for (name, size) in iosSizes {
    writePNG(iosMaster, size: size, to: setPath.appendingPathComponent(name))
    written += 1
}

print("wrote \(written) icons to \(setPath.path)")
