// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
  internal typealias AssetColorTypeAlias = NSColor
  internal typealias AssetImageTypeAlias = NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
  internal typealias AssetColorTypeAlias = UIColor
  internal typealias AssetImageTypeAlias = UIImage
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let askMark = ImageAsset(name: "Ask Mark")
  internal static let markAsDone = ImageAsset(name: "Mark as Done")
  internal static let camera = ImageAsset(name: "camera")
  internal static let deleteButton = ImageAsset(name: "deleteButton")
  internal static let runningMan = ImageAsset(name: "runningMan")
  internal static let add = ImageAsset(name: "add")
  internal static let done = ImageAsset(name: "done")
  internal static let doneBlue = ImageAsset(name: "doneBlue")
  internal static let doneCircle = ImageAsset(name: "doneCircle")
  internal static let doneLittle = ImageAsset(name: "doneLittle")
  internal static let doneNormal = ImageAsset(name: "doneNormal")
  internal static let habitInfo = ImageAsset(name: "Habit_info")
  internal static let betaData = ImageAsset(name: "betaData")
  internal static let goal = ImageAsset(name: "goal")
  internal static let graphIllistration = ImageAsset(name: "graphIllistration")
  internal static let `guard` = ImageAsset(name: "guard")
  internal static let order = ImageAsset(name: "order")
  internal static let stars = ImageAsset(name: "stars")
  internal static let trophy = ImageAsset(name: "trophy")
  internal static let trophyBig = ImageAsset(name: "trophyBig")
  internal static let apple = ImageAsset(name: "apple")
  internal static let dance = ImageAsset(name: "dance")
  internal static let drink = ImageAsset(name: "drink")
  internal static let eat = ImageAsset(name: "eat")
  internal static let meditation = ImageAsset(name: "meditation")
  internal static let read = ImageAsset(name: "read")
  internal static let ride = ImageAsset(name: "ride")
  internal static let running = ImageAsset(name: "running")
  internal static let sleep = ImageAsset(name: "sleep")
  internal static let swim = ImageAsset(name: "swim")
  internal static let walk = ImageAsset(name: "walk")
  internal static let workout = ImageAsset(name: "workout")
  internal static let illustration1 = ImageAsset(name: "Illustration1")
  internal static let illustration2 = ImageAsset(name: "Illustration2")
  internal static let illustration3 = ImageAsset(name: "Illustration3")
  internal static let onboarding1 = ImageAsset(name: "onboarding1")
  internal static let calendar = ImageAsset(name: "calendar")
  internal static let filter = ImageAsset(name: "filter")
  internal static let menu = ImageAsset(name: "menu")
  internal static let plus = ImageAsset(name: "plus")
  internal static let trash = ImageAsset(name: "trash")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal struct ColorAsset {
  internal fileprivate(set) var name: String

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  internal var color: AssetColorTypeAlias {
    return AssetColorTypeAlias(asset: self)
  }
}

internal extension AssetColorTypeAlias {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, OSX 10.13, *)
  convenience init!(asset: ColorAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct DataAsset {
  internal fileprivate(set) var name: String

  #if os(iOS) || os(tvOS) || os(OSX)
  @available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
  internal var data: NSDataAsset {
    return NSDataAsset(asset: self)
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(OSX)
@available(iOS 9.0, tvOS 9.0, OSX 10.11, *)
internal extension NSDataAsset {
  convenience init!(asset: DataAsset) {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(OSX)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  internal var image: AssetImageTypeAlias {
    let bundle = Bundle(for: BundleToken.self)
    #if os(iOS) || os(tvOS)
    let image = AssetImageTypeAlias(named: name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = AssetImageTypeAlias(named: name)
    #endif
    guard let result = image else { fatalError("Unable to load image named \(name).") }
    return result
  }
}

internal extension AssetImageTypeAlias {
  @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
  @available(OSX, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = Bundle(for: BundleToken.self)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(OSX)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

private final class BundleToken {}
