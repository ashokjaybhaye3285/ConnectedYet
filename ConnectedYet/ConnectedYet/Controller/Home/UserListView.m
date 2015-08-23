



#import "UserListView.h"
#import "ProfileViewController.h"

#define DEVICE_WIDTH [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface UserListView ()

@end

@implementation UserListView

- (void)viewDidLoad
{
    [super viewDidLoad];

    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    [self loadListView];
    

}


-(void)loadListView
{
 
    int xPos = 0;
    int yPos = 0;
    
    int btnWidth = (DEVICE_WIDTH-50)/4;
    int btnHeight = btnWidth + 40;

    for(int i =0; i<40; i++)
    {
        UIButton *btnUser = [UIButton buttonWithType:UIButtonTypeCustom];
        btnUser.frame = CGRectMake(xPos, yPos, btnWidth, btnHeight);
        btnUser.tag = i;
        [btnUser addTarget:self action:@selector(btnUserTapped:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btnUser];

        //[btnUser setBackgroundImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];
        //[btnUser setImage:[UIImage imageNamed:@"button-bg"] forState:UIControlStateNormal];

        UIImageView *imageUser = [[UIImageView alloc]init];
        imageUser.frame = CGRectMake(0, 0, btnWidth, btnWidth);
        if(i%2==0)
            imageUser.image = [UIImage imageNamed:@"profile"];
        else
            imageUser.image = [UIImage imageNamed:@"profile1"];

        imageUser.layer.cornerRadius = btnWidth/2;
        imageUser.layer.masksToBounds = btnWidth/2;
        imageUser.layer.borderColor = [[UIColor colorWithRed:81.0/255.0 green:176.0/255.0 blue:180.0/255.0 alpha:1] CGColor];
        imageUser.layer.borderWidth = 2.5;
        [btnUser addSubview:imageUser];

        UIImageView *imageStatus = [[UIImageView alloc]init];
        if(i%2==0)
        imageStatus.image = [UIImage imageNamed:@"status-offline"];
        else if(i%3==0)
            imageStatus.image = [UIImage imageNamed:@"status-online"];
        else
            imageStatus.image = [UIImage imageNamed:@"status-away"];

        [btnUser addSubview:imageStatus];
        
        UIImageView *imageSex = [[UIImageView alloc]init];
       
        imageSex.image = [UIImage imageNamed:@"female-sex"];
        [btnUser addSubview:imageSex];
        
        UILabel *labelName = [[UILabel alloc]init];
        labelName.frame = CGRectMake(5, btnHeight-40, btnWidth-10, 20);
        labelName.text = @"Tina";
        labelName.textAlignment = NSTextAlignmentCenter;
        labelName.textColor = [UIColor whiteColor];
        labelName.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelName];
        
        UILabel *labelDistance = [[UILabel alloc]init];
        labelDistance.frame = CGRectMake(5, btnHeight-25, btnWidth-10, 20);
        labelDistance.text = @"24, 5km";
        labelDistance.textAlignment = NSTextAlignmentCenter;
        labelDistance.textColor = [UIColor colorWithRed:118.0/255.0 green:221.0/255.0 blue:255.0/255.0 alpha:1];
        labelDistance.backgroundColor = [UIColor clearColor];
        [btnUser addSubview:labelDistance];
        
        if(appDelegate.iPad)
        {
            imageStatus.frame = CGRectMake(btnWidth-35, 15, 20, 20);
            imageSex.frame = CGRectMake(btnWidth-35, btnHeight-25-50, 25, 25);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:16];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:14];

        }
        else
        {
            imageStatus.frame = CGRectMake(btnWidth-20, 0, 10, 10);
            imageSex.frame = CGRectMake(btnWidth-20, btnHeight-15-40, 15, 15);
            
            labelName.font = [UIFont fontWithName:@"Helvetica" size:14];
            labelDistance.font = [UIFont fontWithName:@"Helvetica" size:12];

        }
        
        xPos+= btnWidth + 10;
        
        if ((i+1)%4==0)
        {
            xPos = 0;
            yPos+= btnHeight +10;
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, yPos);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setSelectorAnimation:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        imageSelection.frame = CGRectMake(btn.frame.origin.x + btn.frame.size.width/2 -imageSelection.frame.size.width/2, imageSelection.frame.origin.y, imageSelection.frame.size.width, imageSelection.frame.size.height);
        
    }completion:^(BOOL finished){
        
    }];
    
    
}


#pragma mark –-- --- BUTTON CLICK EVENT --- --- 

-(IBAction)btnBackTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)btnUserTapped:(id)sender
{
#if DEBUG
    NSLog(@"-- Tag :%d",[sender tag]);
#endif
    
    ProfileViewController *profile;
    
    if(appDelegate.iPad)
        profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController_iPad" bundle:nil];
    else
        profile = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];

    [self.navigationController pushViewController:profile animated:YES];
    
}

-(IBAction)btnListViewTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(IBAction)btnMapViewTapped:(id)sender
{
    
}


-(IBAction)btnOnlineTapped:(id)sender
{
    [self setSelectorAnimation:sender];
    
}

-(IBAction)btnAllTapped:(id)sender
{
    [self setSelectorAnimation:sender];
    
}

-(IBAction)btnGirlsTapped:(id)sender
{
    [self setSelectorAnimation:sender];
    
}

-(IBAction)btnBoysTapped:(id)sender
{
    [self setSelectorAnimation:sender];
    
}

-(IBAction)btnNewTapped:(id)sender
{
    [self setSelectorAnimation:sender];
    
}


@end
