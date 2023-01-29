//
//  StringExtension.swift
//  InEgypt
//
//  Created by Awady on 8/25/20.
//  Copyright © 2020 AwadyStore. All rights reserved.
//

import UIKit

protocol LocalizationDelegate: AnyObject {
    func resetApp()
}

class LocalizationManager: NSObject {
    enum LanguageDirection {
        case leftToRight
        case rightToLeft
    }
    
    enum Language: String {
        case english = "en"
        case arabic = "ar"
    }
    
    static let shared = LocalizationManager()
    private var bundle: Bundle!
    private var languageKey = "langKey"
    weak var delegate: LocalizationDelegate?
    
    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    // get select language from userdefault
    func getLanguage() -> Language? {
        if let languageCode = UserDefaults.standard.string(forKey: languageKey), let language = Language(rawValue: languageCode) {
            return language
        }
        return nil
    }
    
    // check if language is available
    private func isLanguageAvailable(_ code: String) -> Language? {
        var finalCode = ""
        if code.contains("ar") {
            finalCode = "ar"
        } else if code.contains("en") {
            finalCode = "en"
        }
        return Language(rawValue: finalCode)
    }
    
    private func getLanguageDirection() -> LanguageDirection {
        if let lang = getLanguage() {
            switch lang {
            case .english:
                return .leftToRight
            case .arabic:
                return .rightToLeft
            }
        }
        return .leftToRight
    }
    
    // get localized string for the given code
    func localizedString(for key: String, value comment: String) -> String {
        
//        let localized = bundle.localizedString(forKey: key, value: comment, table: nil)
//            return localized
//
        let resource = getLanguage()

        guard let path = Bundle.main.path(forResource: resource.map { $0.rawValue }, ofType: "lproj") else {
            let basePath = Bundle.main.path(forResource: "Base", ofType: "lproj")!

            return Bundle(path: basePath)!.localizedString(forKey: key, value: comment, table: nil)
        }
        return Bundle(path: path)!.localizedString(forKey: key, value: "", table: nil)
//
    }
    
    // set language for localization
    func setLanguage(language: Language) {
        UserDefaults.standard.set(language.rawValue, forKey: languageKey)
        if let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj") {
            bundle = Bundle(path: path)
        } else {
            resetLocalization()
        }
        UserDefaults.standard.synchronize()
        resetApp()
    }
    
    // reset bundle
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    // reset app for new language
    func resetApp() {
        let direction = getLanguageDirection()
        var semantic: UISemanticContentAttribute!
        switch direction {
        case .leftToRight:
            semantic = .forceLeftToRight
        case .rightToLeft:
            semantic = .forceRightToLeft
        }
        UIView.appearance().semanticContentAttribute = semantic
//        UINavigationBar.appearance().semanticContentAttribute = semantic
        UISearchBar.appearance().semanticContentAttribute = semantic
        
        delegate?.resetApp()
    }
    
    // configure startup language
    func setupInitLanguage() {
        if let selectedLanguage = getLanguage() {
            setLanguage(language: selectedLanguage)
        } else {
            // no language selected or open for 1st time
            let languageCode = Locale.preferredLanguages.first
            if let code = languageCode, let language = isLanguageAvailable(code) {
                setLanguage(language: language)
            } else {
                setLanguage(language: .english)
            }
        }
        resetApp()
    }
}


extension String {
    var localized: String {
        return LocalizationManager.shared.localizedString(for: self, value: "")
    }
}

extension UITextField {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if LocalizationManager.shared.getLanguage() == .arabic {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        }
    }
}
