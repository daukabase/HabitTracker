// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSColor
  public typealias Color = NSColor
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIColor
  public typealias Color = UIColor
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Colors

// swiftlint:disable identifier_name line_length type_body_length
public struct ColorName {
  public let rgbaValue: UInt32
  public var color: Color { return Color(named: self) }

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
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffffff"></span>
  /// Alpha: 100% <br/> (0xffffffff)
  public static let uiWhite = ColorName(rgbaValue: 0xffffffff)
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

// swiftlint:disable operator_usage_whitespace
internal extension Color {
  convenience init(rgbaValue: UInt32) {
    let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
    let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
    let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
    let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: alpha)
  }
}
// swiftlint:enable operator_usage_whitespace

public extension Color {
  convenience init(named color: ColorName) {
    self.init(rgbaValue: color.rgbaValue)
  }
}
