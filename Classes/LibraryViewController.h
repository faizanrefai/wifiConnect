//
//  LibraryViewController.h
//  wifiConnect
//
//  Created by apple on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface LibraryViewController : UIViewController {

 	MPMoviePlayerController *moviePlayer;
	int isType;
	NSData *ReceiveData;
}
@property(nonatomic)int isType;
@property(nonatomic,retain) NSData *ReceiveData;

-(IBAction)closeBtnClicked:(id)sender;
-(void)playVideo;
-(NSString*)dataFilePath:(NSString*) name;
@end
