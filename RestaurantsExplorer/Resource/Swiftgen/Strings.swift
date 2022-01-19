// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum Cell {
    /// CustomCell
    internal static let identifier = L10n.tr("Localizable", "cell.identifier")
  }

  internal enum Default {
    /// 13065
    internal static let category = L10n.tr("Localizable", "default.category")
    /// Kyiv
    internal static let city = L10n.tr("Localizable", "default.city")
  }

  internal enum Font {
    internal enum Detail {
      /// Charter
      internal static let charter = L10n.tr("Localizable", "font.detail.charter")
      /// Cochin
      internal static let cochin = L10n.tr("Localizable", "font.detail.cochin")
      internal enum Helvetica {
        /// HelveticaNeue-SemiBold
        internal static let bold = L10n.tr("Localizable", "font.detail.helvetica.bold")
        /// HelveticaNeue-UltraLight
        internal static let ultralight = L10n.tr("Localizable", "font.detail.helvetica.ultralight")
      }
    }
  }

  internal enum TableView {
    /// TableViewCell
    internal static let cell = L10n.tr("Localizable", "tableView.cell")
  }

  internal enum Title {
    internal enum Label {
      /// Detail
      internal static let detail = L10n.tr("Localizable", "title.label.detail")
      /// Restaurants
      internal static let search = L10n.tr("Localizable", "title.label.search")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
