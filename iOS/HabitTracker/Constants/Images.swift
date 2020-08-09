// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

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
  internal static let more = ImageAsset(name: "more")
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

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image named \(name).")
    }
    return result
  }
}

internal extension ImageAsset.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init!(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    Bundle(for: BundleToken.self)
  }()
}
// swiftlint:enable convenience_type
