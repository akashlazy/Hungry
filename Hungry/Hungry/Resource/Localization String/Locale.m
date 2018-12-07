
#import "Locale.h"

@implementation Locale

- (id)initWithLanguageCode:(NSString *)languageCode countryCode:(NSString *)countryCode name:(NSString *)name {
    
    if (self = [super init]) {
        
        self.languageCode = languageCode;
        self.countryCode = countryCode;
        self.name = name;
    }
    
    return self;
}

@end
