

#import <Foundation/Foundation.h>

@class Locale;

@interface LanguageManager : NSObject

@property (nonatomic, copy) NSArray *availableLocales;

+ (LanguageManager *)sharedLanguageManager;
- (void)setLanguageWithLocale:(Locale *)locale;
- (Locale *)getSelectedLocale;
- (NSString *)getTranslationForKey:(NSString *)key;

@end
