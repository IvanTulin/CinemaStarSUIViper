// Strings+Generated.swift
// Copyright © RoadMap. All rights reserved.

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
enum Constants {
    /// Актеры и сьемочная группа
    static let actorName = Constants.tr("Localizable", "actorName", fallback: "Актеры и сьемочная группа")
    /// chevron.left
    static let backButtonName = Constants.tr("Localizable", "backButtonName", fallback: "chevron.left")
    /// heart
    static let heartButton = Constants.tr("Localizable", "heartButton", fallback: "heart")
    /// Язык
    static let language = Constants.tr("Localizable", "language", fallback: "Язык")
    /// Смотреть
    static let nameButton = Constants.tr("Localizable", "nameButton", fallback: "Смотреть")
    /// Смотрите также
    static let seeAlso = Constants.tr("Localizable", "seeAlso", fallback: "Смотрите также")
    /// Функционал в разработке
    static let textForAlert = Constants.tr("Localizable", "textForAlert", fallback: "Функционал в разработке")
    /// %.1f
    static func textFormat(_ p1: Float) -> String {
        Constants.tr("Localizable", "textFormat", p1, fallback: "%.1f")
    }

    /// Localizable.strings
    ///   CinemaStarMVVM
    ///
    ///   Created by Ivan Tulin on 02.06.2024.
    static let textForTitleLabel = Constants.tr(
        "Localizable",
        "textForTitleLabel",
        fallback: "Смотри исторические\nфильмы на "
    )
    /// CINEMA STAR
    static let textLabel = Constants.tr("Localizable", "textLabel", fallback: "CINEMA STAR")
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Constants {
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
