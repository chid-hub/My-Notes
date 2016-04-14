
#import "Movie.h"

@implementation Movie

- (instancetype)initWithAttributes:(NSDictionary *)attributes {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.movieId = [[attributes valueForKeyPath:@"id"] integerValue];
    self.title = [attributes valueForKeyPath:@"title"];
    
    self.releaseDate = [attributes valueForKeyPath:@"release_date"];
    self.posterPath = [attributes valueForKeyPath:@"poster_path"];
    self.backdropPath = [attributes valueForKeyPath:@"backdrop_path"];
    self.voteAverage = [[attributes valueForKeyPath:@"vote_average"] floatValue];
    self.voteCount = [[attributes valueForKeyPath:@"vote_count"] floatValue];
    
    self.overview = [attributes valueForKeyPath:@"overview"];
    return self;
}

@end