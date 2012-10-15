//
//  LibraryViewController.m
//  wifiConnect
//
//  Created by apple on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LibraryViewController.h"


@implementation LibraryViewController
@synthesize isType,ReceiveData;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	switch (isType) {
		case 0:{
			
			UIImageView	*imgV= [[UIImageView alloc] initWithImage:[UIImage imageWithData:self.ReceiveData]];
			imgV.frame=CGRectMake(0, 45, 320, 400);
			[self.view addSubview:imgV];
		}
			break;
		case 1:
			
			[self playVideo];
			
			
			break;
		default:
			break;
	}
}

-(NSString*)dataFilePath:(NSString*) name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
			 objectAtIndex:0] stringByAppendingPathComponent:name];
}

-(void)playVideo{
	NSLog(@"Play Video");

	NSString *path = [NSString stringWithFormat:@"%@",[self dataFilePath:@"sunil.mov"]];
	[self.ReceiveData writeToFile:path options:NSDataWritingAtomic error:nil];
	
	
	UIWebView *webV= [[UIWebView alloc] init];
	webV.frame=CGRectMake(0, 45, 320, 400);
	[webV loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
	webV.delegate=self;
	//[webV loadData:self.ReceiveData MIMEType:@"video/mov" textEncodingName:nil baseURL:nil];
	[self.view addSubview:webV];
	

/*	moviePlayer=[[MPMoviePlayerController alloc] initWithContentURL:<#(NSURL *)url#>];

	moviePlayer.fullscreen=YES;
	//moviePlayer.view.frame = CGRectMake(0, 0,1024,768);
	moviePlayer.view.frame= self.view.frame; 
	[moviePlayer setShouldAutoplay:YES];
	[moviePlayer setControlStyle:MPMovieControlStyleNone];
	[moviePlayer setRepeatMode:MPMovieRepeatModeNone];
	[moviePlayer prepareToPlay];

	self.view.frame=moviePlayer.view.bounds;
	self.view= moviePlayer.view;
	[(UIView*)[[self.view subviews] lastObject] setBackgroundColor:[UIColor blackColor]];
	self.view.backgroundColor=[UIColor blackColor];
	//[moviePlayer setOrientation:UIDeviceOrientationLandscapeRight animated:YES]; 
	[moviePlayer play];
	//[moviePlayer setOrientation:UIDeviceOrientationLandscapeLeft animated:NO];
	//[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeRight animated:YES];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(moviePlayBackDidFinish:) 
												 name:MPMoviePlayerPlaybackDidFinishNotification 
											   object:moviePlayer];

*/ 
}
- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
	self.view.backgroundColor=[UIColor blackColor];	
	MPMoviePlayerController *theMovie = [notification object];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
	
	if (theMovie.playbackState) {
		[theMovie pause];
		[theMovie stop];
	}
	
	[moviePlayer.view removeFromSuperview]; 
	
}

-(IBAction)closeBtnClicked:(id)sender{
	[self dismissModalViewControllerAnimated:YES];	
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
