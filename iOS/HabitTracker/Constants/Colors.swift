// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
public struct ColorName {
  public let rgbaValue: UInt32
  public var color: Color { return Color(named: self) }

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#3b414b"></span>
  /// Alpha: 100% <br/> (0x3b414bff)
  public static let icons = ColorName(rgbaValue: 0x3b414bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#171d33"></span>
  /// Alpha: 100% <br/> (0x171d33ff)
  public static let textBlack = ColorName(rgbaValue: 0x171d33ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50555c"></span>
  /// Alpha: 100% <br/> (0x50555cff)
  public static let textPrimary = ColorName(rgbaValue: 0x50555cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a5a5"></span>
  /// Alpha: 100% <br/> (0xa5a5a5ff)
  public static let textSecondary = ColorName(rgbaValue: 0xa5a5a5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#4643d3"></span>
  /// Alpha: 100% <br/> (0x4643d3ff)
  public static let uiBlue = ColorName(rgbaValue: 0x4643d3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5affb"></span>
  /// Alpha: 100% <br/> (0xa5affbff)
  public static let uiBlueSecondary = ColorName(rgbaValue: 0xa5affbff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#50555c"></span>
  /// Alpha: 100% <br/> (0x50555cff)
  public static let uiGrayPrimary = ColorName(rgbaValue: 0x50555cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a5a5"></span>
  /// Alpha: 100% <br/> (0xa5a5a5ff)
  public static let uiGraySecondary = ColorName(rgbaValue: 0xa5a5a5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fe805c"></span>
  /// Alpha: 100% <br/> (0xfe805cff)
  public static let uiOrange = ColorName(rgbaValue: 0xfe805cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff5c5c"></span>
  /// Alpha: 100% <br/> (0xff5c5cff)
  public static let uiRed = ColorName(rgbaValue: 0xff5c5cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  public static let uiWhite = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let components = RGBAComponents(rgbaValue: rgbaValue).normalized
    self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
  }
}

private struct RGBAComponents {
  let rgbaValue: UInt32

  private var shifts: [UInt32] {
    [
      rgbaValue >> 24, // red
      rgbaValue >> 16, // green
      rgbaValue >> 8,  // blue
      rgbaValue        // alpha
    ]
  }

  private var components: [CGFloat] {
    shifts.map {
      CGFloat($0 & 0xff)
    }
  }

  var normalized: [CGFloat] {
    components.map { $0 / 255.0 }
  }
}

public extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
