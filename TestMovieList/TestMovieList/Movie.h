#import <Foundation/Foundation.h>
#include "UIKit/UIKit.h"

@interface Movie : NSObject

@property (nonatomic, strong) NSString* title;

@property (nonatomic, assign) NSInteger movieId;

@property (nonatomic, strong) UIImage* mediumPoster;
@property (nonatomic, strong) UIImage* largePoster;

@property (nonatomic, strong) NSString* releaseDate;
@property (nonatomic, strong) NSString* posterPath;
@property (nonatomic, strong) NSString* backdropPath;
@property (nonatomic, strong) NSString* overview;
@property (nonatomic, assign) float voteAverage;
@property (nonatomic, assign) float voteCount;


- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
