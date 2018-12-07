
#ifndef Language_Changer_Constants_h
#define Language_Changer_Constants_h

// NSUserDefaults keys
#define DEFAULTS_KEY_LANGUAGE_CODE @"LanguageCode" // The key against which to store the selected language code.

/*
 * Custom localised string macro, functioning in a similar way to the standard NSLocalisedString().
 */
#define CustomLocalisedString(key, comment) \
    [[LanguageManager sharedLanguageManager] getTranslationForKey:key]

#endif
