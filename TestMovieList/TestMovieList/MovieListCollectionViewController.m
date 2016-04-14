//
//  MovieListCollectionViewController.m
//  TestMovieList
//
//  Created by Chennai Mac4 on 4/3/16.
//  Copyright © 2016 technogems. All rights reserved.
//

#import "MovieListCollectionViewController.h"
#import "MovieCell.h"
#import "MovieAPIClient.h"
#import "UIKit+AFNetworking.h"
#import "Constant.h"

@interface MovieListCollectionViewController ()

@end

@implementation MovieListCollectionViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];

    [self startLoadingAPIData];
    
}
-(void)startLoadingAPIData{
    
  
    NSURLSessionDataTask* task = [[MovieAPIClient sharedClient] moviesForList:@"movie" withBlock:^(NSArray *ary, NSError *error){
        if(!error){
  
            self.moviesList=ary;
           [self.collectionView reloadData];
        }

    }];
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.moviesList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    Movie *movie=[self.moviesList objectAtIndex:indexPath.row];
    if (movie.mediumPoster){
        
        [cell.movieImage setImage:movie.mediumPoster];
    }else{
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSString* posterUrl = [NSString stringWithFormat:@"%@%@", IMAGE_URL, movie.posterPath];
            NSURL *imageURL = [NSURL URLWithString:posterUrl];
            
            __block NSData *imageData;
            imageData =[NSData dataWithContentsOfURL:imageURL];
        
            movie.mediumPoster = [UIImage imageWithData:imageData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                [cell.movieImage setImage:movie.mediumPoster];
            });
        });
        
    }
    cell.titleText.text=movie.title;
    cell.ratingText.text=[NSString stringWithFormat:@"%.01f", movie.voteAverage];
    cell.overViewText.text=movie.overview;
    cell.releaseDateText.text=movie.releaseDate;
    
    cell.layer.masksToBounds = NO;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = 7.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 5.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    float cellWidth = screenWidth ;/// 3.0; //Replace the divisor with the column count requirement. Make sure to have it in float.
    float frmScreen=screenWidth/2.5;
    float height=frmScreen<=278? frmScreen:278;
    CGSize size = CGSizeMake(cellWidth-20.0, height);
    
    return size;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
