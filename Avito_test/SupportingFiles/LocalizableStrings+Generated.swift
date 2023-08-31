// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum AlertService {
    /// Call
    internal static let callTitle = L10n.tr("Localizable", "alertService.callTitle", fallback: "Call")
    /// You don't need to save it. You will not be able to call or send SMS in messengers, but you can write to the author of the ad on the platform
    internal static let message = L10n.tr("Localizable", "alertService.message", fallback: "You don't need to save it. You will not be able to call or send SMS in messengers, but you can write to the author of the ad on the platform")
    /// Write to
    internal static let messageTitle = L10n.tr("Localizable", "alertService.messageTitle", fallback: "Write to")
    /// The number is temporary
    internal static let title = L10n.tr("Localizable", "alertService.title", fallback: "The number is temporary")
  }
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
  internal enum NetworkError {
    /// Data could not be retrieved
    internal static let anotherError = L10n.tr("Localizable", "networkError.anotherError", fallback: "Data could not be retrieved")
    /// Failed to convert the received data
    internal static let parsingError = L10n.tr("Localizable", "networkError.parsingError", fallback: "Failed to convert the received data")
    /// Request execution error
    internal static let requestError = L10n.tr("Localizable", "networkError.requestError", fallback: "Request execution error")
    /// Please try again later
    internal static let tryLater = L10n.tr("Localizable", "networkError.tryLater", fallback: "Please try again later")
    /// Check your internet connection
    internal static let urlSessionError = L10n.tr("Localizable", "networkError.URLSessionError", fallback: "Check your internet connection")
    internal enum Http {
      /// Nothing was found on the request
      internal static let _404 = L10n.tr("Localizable", "networkError.http.404", fallback: "Nothing was found on the request")
      /// Resource update error
      internal static let _409 = L10n.tr("Localizable", "networkError.http.409", fallback: "Resource update error")
      /// The requested resource is no longer available
      internal static let _410 = L10n.tr("Localizable", "networkError.http.410", fallback: "The requested resource is no longer available")
      /// Server-side error
      internal static let _5Хх = L10n.tr("Localizable", "networkError.http.5хх", fallback: "Server-side error")
    }
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
