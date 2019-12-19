//
//  ViewController.m
//  Crackers
//
//  Created by Pavankumar Arepu on 06/11/2015.
//  Copyright © 2015 ppam. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+animatedGIF.h"
#import "WallpaperCollectionCellCollectionViewCell.h"


@interface ViewController ()
{
    NSMutableArray *wallpapersArray,*wallpaperDescriptionArray,*blurImageArray;
    NSTimer *stopBlastTimer,*flightTimer,*splashTimer;
    UIView *animatedView;
    UIImageView *animateImageView,*flightImage,*happyImageView,*dewaliImageView;
    UIButton *animateButton;
    UICollectionView * wallpaperCollectionView;
    
}
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel  *fireCrackerLabel;

@end

@implementation ViewController
int increment = 0;
int timerCounter = 0;

#pragma mark - UIViewController Default Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    wallpapersArray = [[NSMutableArray alloc]initWithObjects:@"CityFog.png",@"FullMoonDay.png",@"Gallaxy.png",@"Love.png",@"MountainStars.png",@"NightCity.png",@"NightStars.png",@"Space.png",@"TreeMoon.png", nil];
    
    wallpaperDescriptionArray = [[NSMutableArray alloc]initWithObjects:@"CityFog",@"FullMoonDay",@"Galaxy",@"Love",@"MountainStars",@"NightCity",@"NightStars",@"Space",@"MoonTree", nil];

    
    animatedView = [[UIView alloc]init];
    animateImageView = [[UIImageView alloc]init];
    animateButton = [[UIButton alloc]init];
    happyImageView = [[UIImageView alloc]init];
    dewaliImageView = [[UIImageView alloc]init];
    flightImage = [[UIImageView alloc]init];
    
    
    flightImage.hidden = YES;
    happyImageView.hidden = YES;
    dewaliImageView.hidden = YES;
    self.fireCrackerLabel.hidden = YES;
    animateButton.hidden = YES;
    
    
    
    happyImageView.image = [UIImage imageNamed:@"Happy.png"];
    dewaliImageView.image = [UIImage imageNamed:@"Diwali.png"];
    
    happyImageView.frame = CGRectMake(40, 20, self.view.frame.size.width-80, self.view.frame.size.height-100);
    dewaliImageView.frame = happyImageView.frame;
    
   
    
    animatedView.frame = CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, self.view.frame.size.height);
    animateButton.frame = CGRectMake(animatedView.center.x, 0, 50, 50);
    animateImageView.frame = CGRectMake(0, animateButton.frame.size.height, self.view.frame.size.width, animatedView.frame.size.height-50);
    
    
    //Collection View creating completely Programitically
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    wallpaperCollectionView=[[UICollectionView alloc] initWithFrame:animateImageView.frame collectionViewLayout:layout];
    [wallpaperCollectionView setDataSource:self];
    [wallpaperCollectionView setDelegate:self];
    [wallpaperCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    wallpaperCollectionView.hidden = NO;

    
    //Adding all UIControls to View and Animated View
    
    [self.view addSubview:self.fireCrackerLabel];
    [self.view addSubview:animatedView];
    [self.view addSubview:happyImageView];
    [self.view addSubview:dewaliImageView];
    [animatedView addSubview:animateButton];
    [animatedView addSubview:animateImageView];
    [animatedView addSubview:wallpaperCollectionView];
    [self.view addSubview:flightImage];

    [animateButton setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
    animateImageView.image = [UIImage imageNamed:@"BlurAnimate.png"];
    wallpaperCollectionView.backgroundColor = [UIColor clearColor];

    [animateButton addTarget:self
                      action:@selector(wallpaperSelection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    flightTimer = [NSTimer scheduledTimerWithTimeInterval:10.0f
                                                   target:self
                                                 selector:@selector(movingFlights)
                                                 userInfo:nil
                                                  repeats:YES];
    [flightTimer fire];
    
    
    splashTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                   target:self
                                                 selector:@selector(HappyStartAnimate)
                                                 userInfo:nil
                                                  repeats:NO];
  
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *aTouch = [touches anyObject];
    CGPoint point = [aTouch locationInView:self.myImageView];
    [self startCrackersAt:point];
    self.fireCrackerLabel.hidden = YES;
    
}


#pragma mark - Custome Methods - Happy Dewali Words Animation

-(void)HappyStartAnimate
{
    happyImageView.hidden = NO;

        happyImageView.layer.anchorPoint = CGPointMake(0.5,0.5);
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        
        bounceAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:1.1],
                                  [NSNumber numberWithFloat:0.9],
                                  [NSNumber numberWithFloat:1.0],

                                  nil];
        
        bounceAnimation.duration = 5.0;
        [bounceAnimation setTimingFunctions:[NSArray arrayWithObjects:
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             nil]];
        [happyImageView.layer addAnimation:bounceAnimation forKey:@"bounce"];
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(DewaliStartAnimate) userInfo:nil repeats:NO];
    
    
    
}
-(void)DewaliStartAnimate
{
        dewaliImageView.hidden = NO;
        dewaliImageView.layer.anchorPoint = CGPointMake(0.5,0.5);
        CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        bounceAnimation.values = [NSArray arrayWithObjects:
                                  [NSNumber numberWithFloat:0.0],
                                  [NSNumber numberWithFloat:1.1],
                                  [NSNumber numberWithFloat:0.9],
                                  [NSNumber numberWithFloat:1.0],
                                  nil];
        bounceAnimation.duration = 5.0;
        [bounceAnimation setTimingFunctions:[NSArray arrayWithObjects:
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                             nil]];
        [dewaliImageView.layer addAnimation:bounceAnimation forKey:@"bounce"];
        [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hideHappyDiwaliImages) userInfo:nil repeats:NO];
}

-(void)hideHappyDiwaliImages
{
    happyImageView.hidden = YES;
    dewaliImageView.hidden = YES;
    flightImage.hidden = NO;
    
    self.fireCrackerLabel.hidden = NO;
    self.fireCrackerLabel.text = @"Touch the screen to Fire Your Crackers on the Fly !!!";
    animateButton.hidden = NO;
    
    
}




#pragma mark - Flight Moving Methods

-(void)movingFlights
{
  int x1 =  arc4random_uniform(self.view.frame.size.height);
  int y1 =  arc4random_uniform(self.view.frame.size.width);
    
    int x2 =  arc4random_uniform(self.view.frame.size.height);
    int y2 =  arc4random_uniform(self.view.frame.size.width);
    
    
    if (x1>x2 && y1>y2)
    {
        [flightImage setImage:[UIImage imageNamed:@"upLeft.png"]];
    }
    
    if (x1>x2 && y1<y2)
    {
        [flightImage setImage:[UIImage imageNamed:@"downLeft.png"]];

    }
    
    if (x1<x2 && y1>y2)
    {
        [flightImage setImage:[UIImage imageNamed:@"upRight.png"]];
    }
    
    if (x1<x2 && y1<y2)
    {
        [flightImage setImage:[UIImage imageNamed:@"downRight.png"]];
        
    }
    
    
    flightImage.frame = CGRectMake(x1, y1, 75, 30);
    [UIView animateWithDuration:10.0f
                     animations:^{
                         flightImage.frame = CGRectMake(x2,y2 ,75, 45);
                     }
                     completion:^(BOOL finished)
                    {
         
                    }
     ];
}


#pragma mark - Crackers Firing location Methods

-(void)startCrackersAt:(CGPoint)point
{
    UIImageView *animateImageV = [[UIImageView alloc]initWithFrame:CGRectMake(100,100 , 300 ,300)];
    if (increment > 9)
    {
        increment = 0;
    }
    else
    {
        increment = increment + 1;
    }

    NSURL *url = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%d",increment] withExtension:@"gif"];
    UIImage *testImage = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    //[animateImageV startAnimating];
    animateImageV.center = point;
    animateImageV.image = testImage;
    animateImageV.animationRepeatCount = 1;
    [self.myImageView addSubview:animateImageV];
    
    stopBlastTimer = [NSTimer scheduledTimerWithTimeInterval:4.0
                                                      target:self
                                                    selector:@selector(stopFiringCrackers)
                                                    userInfo:nil
                                                     repeats:NO];
    
    
    NSLog(@"self.myimageSubView:%@",self.myImageView.subviews);
    NSLog(@"self.myimageSubView Count:%lu",(unsigned long)[self.myImageView.subviews count]);
}

-(void)stopFiringCrackers
{
    if ([self.myImageView.subviews objectAtIndex:timerCounter])
    {
        [[self.myImageView.subviews objectAtIndex:timerCounter] removeFromSuperview];
    }
    else
    {
        [stopBlastTimer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Collection View DataSouce Methods



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [wallpapersArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    if ([wallpapersArray count])
    {
     //   NSLog(@"dataObject Name: %@",[wallpapersArray objectAtIndex:indexPath.row]);

        UIImageView *wallpaper = [[UIImageView alloc]initWithFrame:CGRectMake(20, 20, cell.frame.size.width-40, cell.frame.size.height-80)];
        wallpaper.image = [UIImage imageNamed:[wallpapersArray objectAtIndex:indexPath.row]];
        
        UILabel *wallpaperLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, wallpaper.frame.size.height+20, cell.frame.size.width, 40)];
        
        NSLog(@"Label FrameX : %f", wallpaperLabel.frame.origin.x);
        
        NSLog(@"Label FrameY: %f", wallpaperLabel.frame.origin.x);
        
        NSLog(@"Label BoundsX : %f", wallpaperLabel.bounds.origin.x);
        
        NSLog(@"Label BoundxY : %f", wallpaperLabel.bounds.origin.x);
        
        
        
        wallpaperLabel.textColor = [UIColor whiteColor];
        wallpaperLabel.clipsToBounds = YES;
        wallpaperLabel.text = [wallpaperDescriptionArray objectAtIndex:indexPath.row];
        [wallpaperLabel setFont:[UIFont fontWithName:@"Apple Color Emoji" size:18]];
        wallpaperLabel.textAlignment = NSTextAlignmentCenter;

        cell.backgroundColor = [UIColor grayColor];
        [cell addSubview:wallpaper];
        [cell addSubview:wallpaperLabel];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    self.myImageView.image = [UIImage  imageNamed:[wallpapersArray objectAtIndex:indexPath.row]];
    
    animateButton.selected = NO;
    flightImage.hidden = NO;
    
    animatedView.frame = CGRectMake(0, 70, self.view.frame.size.width,self.view.frame.size.height - 50);
    
    [UIView animateWithDuration:1.0f
                     animations:^{
                         animatedView.frame = CGRectMake(0,self.view.frame.size.height - 50 , self.view.frame.size.width,self.view.frame.size.height - 50);
                         
                     }
                     completion:^(BOOL finished)
     {
       //  NSLog(@"Came Down");
         
         [animateButton setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
     }
     ];
    
    
}




#pragma mark - Wallpaper Selection Method

- (IBAction)wallpaperSelection:(id)sender
{
   // NSLog(@"CollectionView Frame: %@",wallpaperCollectionView);
    if (animateButton.selected)
    {
        animateButton.selected = NO;
        flightImage.hidden = NO;

        animatedView.frame = CGRectMake(0, 70, self.view.frame.size.width,self.view.frame.size.height - 50);
        
                                                                            

        [UIView animateWithDuration:1.0f
                         animations:^{
                             animatedView.frame = CGRectMake(0,self.view.frame.size.height - 50 , self.view.frame.size.width,self.view.frame.size.height - 50);
                             
                         }
                         completion:^(BOOL finished)
                        {
                         //   NSLog(@"Came Down");

                            [animateButton setImage:[UIImage imageNamed:@"upArrow.png"] forState:UIControlStateNormal];
                        }
         ];
    }else
    {

        animateButton.selected = YES;
        flightImage.hidden = YES;

 animatedView.frame = CGRectMake(0,self.view.frame.size.height - 50 , self.view.frame.size.width,self.view.frame.size.height - 50);
        [UIView animateWithDuration:1.0f
                     animations:^{
                         animatedView.frame = CGRectMake(0, 70, self.view.frame.size.width,self.view.frame.size.height - 50);
                         
                         
                     }
                     completion:^(BOOL finished)
                    {
                      //  NSLog(@"Came UP");
                        [animateButton setImage:[UIImage imageNamed:@"downArrow.png"] forState:UIControlStateNormal];

                    }
         ];
    }
}


- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(200.f, 200.f);

}


@end
