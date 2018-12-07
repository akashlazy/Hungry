
#import <Foundation/Foundation.h>

@interface Locale : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *languageCode;
@property (nonatomic, copy) NSString *countryCode;

- (id)initWithLanguageCode:(NSString *)languageCode countryCode:(NSString *)countryCode name:(NSString *)name;

@end
