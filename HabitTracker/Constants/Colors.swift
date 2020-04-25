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

  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fbccc9"></span>
  /// Alpha: 100% <br/> (0xfbccc9ff)
  public static let buttonPrimaryInactive = ColorName(rgbaValue: 0xfbccc9ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f1463b"></span>
  /// Alpha: 100% <br/> (0xf1463bff)
  public static let buttonPrimaryNormal = ColorName(rgbaValue: 0xf1463bff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f03226"></span>
  /// Alpha: 100% <br/> (0xf03226ff)
  public static let buttonPrimaryPressed = ColorName(rgbaValue: 0xf03226ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f3f4f5"></span>
  /// Alpha: 100% <br/> (0xf3f4f5ff)
  public static let buttonSecondaryInactive = ColorName(rgbaValue: 0xf3f4f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ecedef"></span>
  /// Alpha: 100% <br/> (0xecedefff)
  public static let buttonSecondaryNormal = ColorName(rgbaValue: 0xecedefff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#fff7f7"></span>
  /// Alpha: 100% <br/> (0xfff7f7ff)
  public static let interfaceImportantInfo = ColorName(rgbaValue: 0xfff7f7ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f03226"></span>
  /// Alpha: 100% <br/> (0xf03226ff)
  public static let redBrand = ColorName(rgbaValue: 0xf03226ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ffe3e3"></span>
  /// Alpha: 100% <br/> (0xffe3e3ff)
  public static let strokeImportantInfo = ColorName(rgbaValue: 0xffe3e3ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#5fae50"></span>
  /// Alpha: 100% <br/> (0x5fae50ff)
  public static let textGreen = ColorName(rgbaValue: 0x5fae50ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#9fce96"></span>
  /// Alpha: 100% <br/> (0x9fce96ff)
  public static let textGreenSecondary = ColorName(rgbaValue: 0x9fce96ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#546271"></span>
  /// Alpha: 100% <br/> (0x546271ff)
  public static let textParagraph = ColorName(rgbaValue: 0x546271ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#172a3f"></span>
  /// Alpha: 100% <br/> (0x172a3fff)
  public static let textPrimary = ColorName(rgbaValue: 0x172a3fff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#6d7986"></span>
  /// Alpha: 100% <br/> (0x6d7986ff)
  public static let textSecondary = ColorName(rgbaValue: 0x6d7986ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b5bbc2"></span>
  /// Alpha: 100% <br/> (0xb5bbc2ff)
  public static let textTetriary = ColorName(rgbaValue: 0xb5bbc2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#a5a8ac"></span>
  /// Alpha: 100% <br/> (0xa5a8acff)
  public static let textWhiteSecondary = ColorName(rgbaValue: 0xa5a8acff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f3f4f5"></span>
  /// Alpha: 100% <br/> (0xf3f4f5ff)
  public static let uiBackground = ColorName(rgbaValue: 0xf3f4f5ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#2b3a4a"></span>
  /// Alpha: 100% <br/> (0x2b3a4aff)
  public static let uiCard = ColorName(rgbaValue: 0x2b3a4aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#b5bbc2"></span>
  /// Alpha: 100% <br/> (0xb5bbc2ff)
  public static let uiGray = ColorName(rgbaValue: 0xb5bbc2ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#0dba26"></span>
  /// Alpha: 100% <br/> (0x0dba26ff)
  public static let uiGreenSuccess = ColorName(rgbaValue: 0x0dba26ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#222932"></span>
  /// Alpha: 100% <br/> (0x222932ff)
  public static let uiPrimary = ColorName(rgbaValue: 0x222932ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#f0453a"></span>
  /// Alpha: 100% <br/> (0xf0453aff)
  public static let uiRed = ColorName(rgbaValue: 0xf0453aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#ff5c5c"></span>
  /// Alpha: 100% <br/> (0xff5c5cff)
  public static let uiRedError = ColorName(rgbaValue: 0xff5c5cff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#858f9a"></span>
  /// Alpha: 100% <br/> (0x858f9aff)
  public static let uiSecondary = ColorName(rgbaValue: 0x858f9aff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#383e46"></span>
  /// Alpha: 100% <br/> (0x383e46ff)
  public static let uiSeparatorDark = ColorName(rgbaValue: 0x383e46ff)
  /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#e8e9ea"></span>
  /// Alpha: 100% <br/> (0xe8e9eaff)
  public static let uiSeparatorWhite = ColorName(rgbaValue: 0xe8e9eaff)
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
