//
//  MovieCell.h
//  TestMovieList
//
//  Created by Chennai Mac4 on 4/3/16.
//  Copyright © 2016 technogems. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *movieImage;
@property (strong, nonatomic) IBOutlet UILabel *titleText;
@property (strong, nonatomic) IBOutlet UILabel *overViewText;
@property (strong, nonatomic) IBOutlet UILabel *ratingText;
@property (strong, nonatomic) IBOutlet UILabel *releaseDateText;

@end
