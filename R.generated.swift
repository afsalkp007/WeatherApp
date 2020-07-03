//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap { Locale(identifier: $0) } ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)

  /// Find first language and bundle for which the table exists
  fileprivate static func localeBundle(tableName: String, preferredLanguages: [String]) -> (Foundation.Locale, Foundation.Bundle)? {
    // Filter preferredLanguages to localizations, use first locale
    var languages = preferredLanguages
      .map { Locale(identifier: $0) }
      .prefix(1)
      .flatMap { locale -> [String] in
        if hostingBundle.localizations.contains(locale.identifier) {
          if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
            return [locale.identifier, language]
          } else {
            return [locale.identifier]
          }
        } else if let language = locale.languageCode, hostingBundle.localizations.contains(language) {
          return [language]
        } else {
          return []
        }
      }

    // If there's no languages, use development language as backstop
    if languages.isEmpty {
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages = [developmentLocalization]
      }
    } else {
      // Insert Base as second item (between locale identifier and languageCode)
      languages.insert("Base", at: 1)

      // Add development language as backstop
      if let developmentLocalization = hostingBundle.developmentLocalization {
        languages.append(developmentLocalization)
      }
    }

    // Find first language for which table exists
    // Note: key might not exist in chosen language (in that case, key will be shown)
    for language in languages {
      if let lproj = hostingBundle.url(forResource: language, withExtension: "lproj"),
         let lbundle = Bundle(url: lproj)
      {
        let strings = lbundle.url(forResource: tableName, withExtension: "strings")
        let stringsdict = lbundle.url(forResource: tableName, withExtension: "stringsdict")

        if strings != nil || stringsdict != nil {
          return (Locale(identifier: language), lbundle)
        }
      }
    }

    // If table is available in main bundle, don't look for localized resources
    let strings = hostingBundle.url(forResource: tableName, withExtension: "strings", subdirectory: nil, localization: nil)
    let stringsdict = hostingBundle.url(forResource: tableName, withExtension: "stringsdict", subdirectory: nil, localization: nil)

    if strings != nil || stringsdict != nil {
      return (applicationLocale, hostingBundle)
    }

    // If table is not found for requested languages, key will be shown
    return nil
  }

  /// Load string from Info.plist file
  fileprivate static func infoPlistString(path: [String], key: String) -> String? {
    var dict = hostingBundle.infoDictionary
    for step in path {
      guard let obj = dict?[step] as? [String: Any] else { return nil }
      dict = obj
    }
    return dict?[key] as? String
  }

  static func validate() throws {
    try intern.validate()
  }

  #if os(iOS) || os(tvOS)
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    #endif

    fileprivate init() {}
  }
  #endif

  /// This `R.image` struct is generated, and contains static references to 17 images.
  struct image {
    /// Image `AirPressure`.
    static let airPressure = Rswift.ImageResource(bundle: R.hostingBundle, name: "AirPressure")
    /// Image `CloudCoverFilled`.
    static let cloudCoverFilled = Rswift.ImageResource(bundle: R.hostingBundle, name: "CloudCoverFilled")
    /// Image `CloudCover`.
    static let cloudCover = Rswift.ImageResource(bundle: R.hostingBundle, name: "CloudCover")
    /// Image `Distance`.
    static let distance = Rswift.ImageResource(bundle: R.hostingBundle, name: "Distance")
    /// Image `HumidityFilled`.
    static let humidityFilled = Rswift.ImageResource(bundle: R.hostingBundle, name: "HumidityFilled")
    /// Image `Humidity`.
    static let humidity = Rswift.ImageResource(bundle: R.hostingBundle, name: "Humidity")
    /// Image `Location`.
    static let location = Rswift.ImageResource(bundle: R.hostingBundle, name: "Location")
    /// Image `OpenWeatherMapLogo`.
    static let openWeatherMapLogo = Rswift.ImageResource(bundle: R.hostingBundle, name: "OpenWeatherMapLogo")
    /// Image `Sunrise`.
    static let sunrise = Rswift.ImageResource(bundle: R.hostingBundle, name: "Sunrise")
    /// Image `Sunset`.
    static let sunset = Rswift.ImageResource(bundle: R.hostingBundle, name: "Sunset")
    /// Image `Temperature`.
    static let temperature = Rswift.ImageResource(bundle: R.hostingBundle, name: "Temperature")
    /// Image `VerticalCloseButton`.
    static let verticalCloseButton = Rswift.ImageResource(bundle: R.hostingBundle, name: "VerticalCloseButton")
    /// Image `WindDirection`.
    static let windDirection = Rswift.ImageResource(bundle: R.hostingBundle, name: "WindDirection")
    /// Image `WindSpeed`.
    static let windSpeed = Rswift.ImageResource(bundle: R.hostingBundle, name: "WindSpeed")
    /// Image `notFound`.
    static let notFound = Rswift.ImageResource(bundle: R.hostingBundle, name: "notFound")
    /// Image `tabbar_list_ios11`.
    static let tabbar_list_ios11 = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_list_ios11")
    /// Image `tabbar_map_ios11`.
    static let tabbar_map_ios11 = Rswift.ImageResource(bundle: R.hostingBundle, name: "tabbar_map_ios11")

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "AirPressure", bundle: ..., traitCollection: ...)`
    static func airPressure(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.airPressure, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CloudCover", bundle: ..., traitCollection: ...)`
    static func cloudCover(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cloudCover, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "CloudCoverFilled", bundle: ..., traitCollection: ...)`
    static func cloudCoverFilled(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.cloudCoverFilled, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Distance", bundle: ..., traitCollection: ...)`
    static func distance(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.distance, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Humidity", bundle: ..., traitCollection: ...)`
    static func humidity(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.humidity, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "HumidityFilled", bundle: ..., traitCollection: ...)`
    static func humidityFilled(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.humidityFilled, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Location", bundle: ..., traitCollection: ...)`
    static func location(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.location, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "OpenWeatherMapLogo", bundle: ..., traitCollection: ...)`
    static func openWeatherMapLogo(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.openWeatherMapLogo, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Sunrise", bundle: ..., traitCollection: ...)`
    static func sunrise(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sunrise, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Sunset", bundle: ..., traitCollection: ...)`
    static func sunset(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.sunset, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "Temperature", bundle: ..., traitCollection: ...)`
    static func temperature(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.temperature, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "VerticalCloseButton", bundle: ..., traitCollection: ...)`
    static func verticalCloseButton(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.verticalCloseButton, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "WindDirection", bundle: ..., traitCollection: ...)`
    static func windDirection(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.windDirection, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "WindSpeed", bundle: ..., traitCollection: ...)`
    static func windSpeed(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.windSpeed, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "notFound", bundle: ..., traitCollection: ...)`
    static func notFound(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.notFound, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_list_ios11", bundle: ..., traitCollection: ...)`
    static func tabbar_list_ios11(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_list_ios11, compatibleWith: traitCollection)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UIImage(named: "tabbar_map_ios11", bundle: ..., traitCollection: ...)`
    static func tabbar_map_ios11(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.tabbar_map_ios11, compatibleWith: traitCollection)
    }
    #endif

    fileprivate init() {}
  }

  /// This `R.nib` struct is generated, and contains static references to 2 nibs.
  struct nib {
    /// Nib `AddFavoriteCell`.
    static let addFavoriteCell = _R.nib._AddFavoriteCell()
    /// Nib `ListCell`.
    static let listCell = _R.nib._ListCell()

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "AddFavoriteCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.addFavoriteCell) instead")
    static func addFavoriteCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.addFavoriteCell)
    }
    #endif

    #if os(iOS) || os(tvOS)
    /// `UINib(name: "ListCell", in: bundle)`
    @available(*, deprecated, message: "Use UINib(resource: R.nib.listCell) instead")
    static func listCell(_: Void = ()) -> UIKit.UINib {
      return UIKit.UINib(resource: R.nib.listCell)
    }
    #endif

    static func addFavoriteCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AddFavoriteCell? {
      return R.nib.addFavoriteCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AddFavoriteCell
    }

    static func listCell(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ListCell? {
      return R.nib.listCell.instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ListCell
    }

    fileprivate init() {}
  }

  /// This `R.reuseIdentifier` struct is generated, and contains static references to 2 reuse identifiers.
  struct reuseIdentifier {
    /// Reuse identifier `AddFavoriteCell`.
    static let addFavoriteCell: Rswift.ReuseIdentifier<AddFavoriteCell> = Rswift.ReuseIdentifier(identifier: "AddFavoriteCell")
    /// Reuse identifier `ListCell`.
    static let listCell: Rswift.ReuseIdentifier<ListCell> = Rswift.ReuseIdentifier(identifier: "ListCell")

    fileprivate init() {}
  }

  /// This `R.string` struct is generated, and contains static references to 1 localization tables.
  struct string {
    /// This `R.string.localizable` struct is generated, and contains static references to 10 localization keys.
    struct localizable {
      /// en translation: Coordinates
      ///
      /// Locales: en
      static let coordinates = Rswift.StringResource(key: "coordinates", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Distance
      ///
      /// Locales: en
      static let distance = Rswift.StringResource(key: "distance", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Imperial
      ///
      /// Locales: en
      static let imperial = Rswift.StringResource(key: "imperial", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Map
      ///
      /// Locales: en
      static let tab_weatherMap = Rswift.StringResource(key: "tab_weatherMap", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Metric
      ///
      /// Locales: en
      static let metric = Rswift.StringResource(key: "metric", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: Search by Name
      ///
      /// Locales: en
      static let search_by_name = Rswift.StringResource(key: "search_by_name", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: km
      ///
      /// Locales: en
      static let km = Rswift.StringResource(key: "km", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: km/h
      ///
      /// Locales: en
      static let kph = Rswift.StringResource(key: "kph", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: mi
      ///
      /// Locales: en
      static let mi = Rswift.StringResource(key: "mi", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)
      /// en translation: mp/h
      ///
      /// Locales: en
      static let mph = Rswift.StringResource(key: "mph", tableName: "Localizable", bundle: R.hostingBundle, locales: ["en"], comment: nil)

      /// en translation: Coordinates
      ///
      /// Locales: en
      static func coordinates(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("coordinates", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "coordinates"
        }

        return NSLocalizedString("coordinates", bundle: bundle, comment: "")
      }

      /// en translation: Distance
      ///
      /// Locales: en
      static func distance(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("distance", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "distance"
        }

        return NSLocalizedString("distance", bundle: bundle, comment: "")
      }

      /// en translation: Imperial
      ///
      /// Locales: en
      static func imperial(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("imperial", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "imperial"
        }

        return NSLocalizedString("imperial", bundle: bundle, comment: "")
      }

      /// en translation: Map
      ///
      /// Locales: en
      static func tab_weatherMap(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("tab_weatherMap", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "tab_weatherMap"
        }

        return NSLocalizedString("tab_weatherMap", bundle: bundle, comment: "")
      }

      /// en translation: Metric
      ///
      /// Locales: en
      static func metric(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("metric", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "metric"
        }

        return NSLocalizedString("metric", bundle: bundle, comment: "")
      }

      /// en translation: Search by Name
      ///
      /// Locales: en
      static func search_by_name(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("search_by_name", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "search_by_name"
        }

        return NSLocalizedString("search_by_name", bundle: bundle, comment: "")
      }

      /// en translation: km
      ///
      /// Locales: en
      static func km(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("km", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "km"
        }

        return NSLocalizedString("km", bundle: bundle, comment: "")
      }

      /// en translation: km/h
      ///
      /// Locales: en
      static func kph(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("kph", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "kph"
        }

        return NSLocalizedString("kph", bundle: bundle, comment: "")
      }

      /// en translation: mi
      ///
      /// Locales: en
      static func mi(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("mi", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "mi"
        }

        return NSLocalizedString("mi", bundle: bundle, comment: "")
      }

      /// en translation: mp/h
      ///
      /// Locales: en
      static func mph(preferredLanguages: [String]? = nil) -> String {
        guard let preferredLanguages = preferredLanguages else {
          return NSLocalizedString("mph", bundle: hostingBundle, comment: "")
        }

        guard let (_, bundle) = localeBundle(tableName: "Localizable", preferredLanguages: preferredLanguages) else {
          return "mph"
        }

        return NSLocalizedString("mph", bundle: bundle, comment: "")
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }

  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }

    fileprivate init() {}
  }

  fileprivate class Class {}

  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    #if os(iOS) || os(tvOS)
    try nib.validate()
    #endif
    #if os(iOS) || os(tvOS)
    try storyboard.validate()
    #endif
  }

  #if os(iOS) || os(tvOS)
  struct nib: Rswift.Validatable {
    static func validate() throws {
      try _ListCell.validate()
    }

    struct _AddFavoriteCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType {
      typealias ReusableType = AddFavoriteCell

      let bundle = R.hostingBundle
      let identifier = "AddFavoriteCell"
      let name = "AddFavoriteCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> AddFavoriteCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? AddFavoriteCell
      }

      fileprivate init() {}
    }

    struct _ListCell: Rswift.NibResourceType, Rswift.ReuseIdentifierType, Rswift.Validatable {
      typealias ReusableType = ListCell

      let bundle = R.hostingBundle
      let identifier = "ListCell"
      let name = "ListCell"

      func firstView(owner ownerOrNil: AnyObject?, options optionsOrNil: [UINib.OptionsKey : Any]? = nil) -> ListCell? {
        return instantiate(withOwner: ownerOrNil, options: optionsOrNil)[0] as? ListCell
      }

      static func validate() throws {
        if UIKit.UIImage(named: "CloudCoverFilled", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'CloudCoverFilled' is used in nib 'ListCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "HumidityFilled", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'HumidityFilled' is used in nib 'ListCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Temperature", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Temperature' is used in nib 'ListCell', but couldn't be loaded.") }
        if UIKit.UIImage(named: "WindSpeed", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'WindSpeed' is used in nib 'ListCell', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }

    fileprivate init() {}
  }
  #endif

  #if os(iOS) || os(tvOS)
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      #if os(iOS) || os(tvOS)
      try launchScreen.validate()
      #endif
      #if os(iOS) || os(tvOS)
      try main.validate()
      #endif
    }

    #if os(iOS) || os(tvOS)
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController

      let bundle = R.hostingBundle
      let name = "LaunchScreen"

      static func validate() throws {
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
      }

      fileprivate init() {}
    }
    #endif

    #if os(iOS) || os(tvOS)
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UINavigationController

      let bundle = R.hostingBundle
      let name = "Main"
      let weatherDetailViewController = StoryboardViewControllerResource<WeatherDetailViewController>(identifier: "WeatherDetailViewController")

      func weatherDetailViewController(_: Void = ()) -> WeatherDetailViewController? {
        return UIKit.UIStoryboard(resource: self).instantiateViewController(withResource: weatherDetailViewController)
      }

      static func validate() throws {
        if UIKit.UIImage(named: "AirPressure", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'AirPressure' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "CloudCover", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'CloudCover' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Distance", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Distance' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Humidity", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Humidity' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Location", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Location' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "OpenWeatherMapLogo", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'OpenWeatherMapLogo' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Sunrise", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Sunrise' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "Sunset", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'Sunset' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "WindDirection", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'WindDirection' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "WindSpeed", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'WindSpeed' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "tabbar_list_ios11", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'tabbar_list_ios11' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, tvOS 11.0, *) {
        }
        if _R.storyboard.main().weatherDetailViewController() == nil { throw Rswift.ValidationError(description:"[R.swift] ViewController with identifier 'weatherDetailViewController' could not be loaded from storyboard 'Main' as 'WeatherDetailViewController'.") }
      }

      fileprivate init() {}
    }
    #endif

    fileprivate init() {}
  }
  #endif

  fileprivate init() {}
}
