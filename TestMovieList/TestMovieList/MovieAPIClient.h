#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import "Movie.h"


@interface MovieAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@property (nonatomic, strong) NSDictionary* apiKeyParameter;

- (NSURLSessionDataTask *)moviesForList:(NSString*)list withBlock:(void (^)(NSArray *movies, NSError *error))block;
@end