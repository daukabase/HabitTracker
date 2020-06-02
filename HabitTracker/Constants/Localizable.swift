// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Onboarding {
    internal enum Auth {
      /// So now if you are motivated enough and ready to achieve your goals, let’s create an account and start your first habit. 
      internal static let description = L10n.tr("Localizable", "Onboarding.Auth.description")
      /// Let’s Start!
      internal static let title = L10n.tr("Localizable", "Onboarding.Auth.title")
    }
    internal enum Challenge {
      /// Be a good friend and change life for the better not only for yourself. Invite friends to create a challenge and motivate each other.
      internal static let description = L10n.tr("Localizable", "Onboarding.Challenge.description")
      /// Challenge accepted!
      internal static let title = L10n.tr("Localizable", "Onboarding.Challenge.title")
    }
    internal enum Goal {
      /// Already have a goal and want to reach it?\n A few clicks and you can get a little closer to it. 
      internal static let description = L10n.tr("Localizable", "Onboarding.Goal.description")
      /// Forward to the Goal
      internal static let title = L10n.tr("Localizable", "Onboarding.Goal.title")
    }
    internal enum Track {
      /// Creat habits that you what to start and keep track of your progress.
      internal static let description = L10n.tr("Localizable", "Onboarding.Track.description")
      /// Track your Habits
      internal static let title = L10n.tr("Localizable", "Onboarding.Track.title")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
