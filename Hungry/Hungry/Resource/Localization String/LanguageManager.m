
#import "LanguageManager.h"
#import "Locale.h"
#import "Constants.h"

@implementation LanguageManager

#pragma mark - Object Lifecycle
+ (LanguageManager *)sharedLanguageManager {
    
    // Create a singleton.
    static dispatch_once_t once;
    static LanguageManager *languageManager;
    dispatch_once(&once, ^ { languageManager = [[LanguageManager alloc] init]; });
    return languageManager;
}

- (id)init {
    if (self = [super init]) {
        
        // Manually create a list of available localisations for this example project.
        Locale *english = [[Locale alloc] initWithLanguageCode:@"en" countryCode:@"gb" name:@"English"];
        Locale *hindi = [[Locale alloc] initWithLanguageCode:@"hi" countryCode:@"in" name:@"हिन्दी"];
        Locale *marathi = [[Locale alloc] initWithLanguageCode:@"mr" countryCode:@"in" name:@"मराठी"];
        
        self.availableLocales = @[english, hindi, marathi];
    }
    return self;
}

#pragma mark - Methods

/*!
 * @function setLanguageWithLocalisation:
 *
 * @abstract
 * Sets the language code string in the user defaults, based on the given Localisation object.
 *
 * @param localisation
 * The localisation object whose language code we are storing in the user defaults.
 */
- (void)setLanguageWithLocale:(Locale *)locale {
    [[NSUserDefaults standardUserDefaults] setObject:locale.languageCode forKey:DEFAULTS_KEY_LANGUAGE_CODE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/*!
 * @function getSelectedLocalisation
 *
 * @abstract
 * Get the localisation object from the list of available localisations that matches the language code
 * stored in the user defaults.
 *
 * @return
 * The Localisation object based on the language code stored in the user defaults.
 *
 * @discussion
 * Returns nil if a language code has not been set in the user defaults.
 */
- (Locale *)getSelectedLocale {
    Locale *selectedLocale = nil;
    
    // Get the language code.
    NSString *languageCode = [[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULTS_KEY_LANGUAGE_CODE] lowercaseString];
    
    // Iterate through available localisations to find the one that matches languageCode.
    for (Locale *locale in self.availableLocales) {
        if ([locale.languageCode caseInsensitiveCompare:languageCode] == NSOrderedSame) {
            selectedLocale = locale;
            break;
        }
    }
    return selectedLocale;
}

/*!
 * @function getTranslationForKey:
 *
 * @abstract
 * Return a translated string for the given string key.
 *
 * @param key
 * The key of the string whose translation we want to look up.
 *
 * @return
 * The translated string for the given key.
 *
 * @discussion
 * Uses the string stored in the user defaults to determine which language to translate to. Translations for
 * keys are found in the Localisable.strings files in the relevant .lproj folder for the selected language.
 */
- (NSString *)getTranslationForKey:(NSString *)key {
    // Get the language code.
    NSString *languageCode = [[[NSUserDefaults standardUserDefaults] stringForKey:DEFAULTS_KEY_LANGUAGE_CODE] lowercaseString];

    // Get the relevant language bundle.
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:languageCode ofType:@"lproj"];
    NSBundle *languageBundle = [NSBundle bundleWithPath:bundlePath];
    
    // Get the translated string using the language bundle.
    NSString *translatedString = [languageBundle localizedStringForKey:key value:@"" table:nil];
    
    if (translatedString.length < 1) {
        // There is no localizable strings file for the selected language.
        translatedString = NSLocalizedStringWithDefaultValue(key, nil, [NSBundle mainBundle], key, key);
    }
    return translatedString;
}

@end
