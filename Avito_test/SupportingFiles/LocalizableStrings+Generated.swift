// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum BaseButton {
    /// 📞 Call
    internal static let call = L10n.tr("Localizable", "baseButton.call", fallback: "📞 Call")
    /// 💬 Message
    internal static let write = L10n.tr("Localizable", "baseButton.write", fallback: "💬 Message")
  }
  internal enum Catalog {
    /// Oops, there doesn't seem to be anything 🥹
    internal static let noProducts = L10n.tr("Localizable", "catalog.noProducts", fallback: "Oops, there doesn't seem to be anything 🥹")
    /// Localizable.strings
    ///   Avito_test
    /// 
    ///   Created by Евгений on 31.08.2023.
    internal static let searching = L10n.tr("Localizable", "catalog.searching", fallback: "Search by name...")
  }
  internal enum Product {
    /// Ad from
    internal static let advertisementFrom = L10n.tr("Localizable", "product.advertisementFrom", fallback: "Ad from")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
