//
//  ECJWT.h
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "NSString+Base64StringFromData.h"
#import <CommonCrypto/CommonHMAC.h>

@interface ECJWT : NSObject
+ (NSString *)encodePayload:(NSDictionary *)payload secret:(NSString *)secret;
@end
