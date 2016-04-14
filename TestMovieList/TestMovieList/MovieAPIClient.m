//
//  AmazonMWSClient.m
//  AmazonMWS
//
//  Created by Tope Abayomi on 11/09/2013.
//  Copyright (c) 2013 App Design Vault. All rights reserved.
//
#import "Constant.h"
#import "MovieAPIClient.h"


@interface MovieAPIClient ()

@end

@implementation MovieAPIClient

+ (instancetype)sharedClient {
    static MovieAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MovieAPIClient alloc] initWithBaseURL:[NSURL URLWithString:MAIN_URL]];
        _sharedClient.apiKeyParameter = @{@"api_key" : MOVIE_DB_API_KEY};
    });
    
    return _sharedClient;
}


- (NSURLSessionDataTask *)moviesForList:(NSString*)list withBlock:(void (^)(NSArray *movies, NSError *error))block{
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters addEntriesFromDictionary:self.apiKeyParameter];
    [parameters setObject:@"2016-01-01" forKey:@"primary_release_date.gte"];
    [parameters setObject:@"2016-03-31" forKey:@"primary_release_date.lte"];
    
   // NSString* path = [NSString stringWithFormat:@"movie/%@", list];
    
    return [[MovieAPIClient sharedClient] GET:list parameters:parameters success:^(NSURLSessionDataTask * __unused task, id JSON) {
        
        NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"release_date" ascending:NO];
        NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc] initWithKey:@"vote_average" ascending:NO];
        
        NSArray *objectsFromResponse = [[JSON valueForKeyPath:@"results"] sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
        
        NSMutableArray *mutableObjects = [NSMutableArray arrayWithCapacity:[objectsFromResponse count]];
        
        for (NSDictionary *attributes in objectsFromResponse) {
            Movie *movie = [[Movie alloc] initWithAttributes:attributes];
            [mutableObjects addObject:movie];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableObjects], nil);
        }
        
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

@end


