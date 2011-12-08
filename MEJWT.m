//
//  ECJWT.m
//

#import "ECJWT.h"

@interface ECJWT()
+ (NSData *)sign:(NSString *)data key:(NSString *)key;
@end

@implementation ECJWT
+ (NSString *)encodePayload:(NSDictionary *)payload secret:(NSString *)secret
{
  NSMutableArray *segments = [NSMutableArray array];
  NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:@"JWT", @"typ", @"HS256", @"alg", nil];
  NSData *jsonHeader = [header JSONData];
  NSData *jsonPayload = [payload JSONData];
  NSString *encodedJsonHeader = [NSString base64StringFromData:jsonHeader];
  NSString *encodedJsonPayload = [NSString base64StringFromData:jsonPayload];
  
  [segments addObject:encodedJsonHeader];
  [segments addObject:[encodedJsonPayload substringToIndex:((int)[encodedJsonPayload length] - 1)]]; // yeah, i dunno
  
  NSString *signingInput = [segments componentsJoinedByString:@"."];
  NSData *signedInput  = [self sign:signingInput key:secret];
  NSString *encodedSignedInput = [NSString base64StringFromData:signedInput];
  [segments addObject:encodedSignedInput];
  
  return [segments componentsJoinedByString:@"."];
}

+ (NSData *)sign:(NSString *)data key:(NSString *)key
{
  const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
  const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
  
  unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
  
  CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
  
  NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                        length:sizeof(cHMAC)];
  
  return HMAC;
}

@end
