//  Taken and modified from:
//  http://stackoverflow.com/questions/392464/any-base64-library-on-iphone-sdk
//

#import <Foundation/Foundation.h>

@interface NSString (Base64StringFromData)
+ (NSString *) base64StringFromData:(NSData *)data length:(int)length;
+ (NSString *) base64StringFromData:(NSData *)data;
@end
