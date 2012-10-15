//
//  wifiConnectViewController.h
//  wifiConnect
//
//  Created by apple on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListOfDevices.h"
#import "wifiConnectAppDelegate.h"
#import "AlertHandler.h"
#import <GameKit/GameKit.h>
#import "LibraryViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
@interface wifiConnectViewController : UIViewController <GKVoiceChatClient,UIAlertViewDelegate,GKPeerPickerControllerDelegate,GKSessionDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate,UIPickerViewDataSource,UIAlertViewDelegate>{

	UIActionSheet *actionSheet1;
//	UIPickerView *picker1;
	wifiConnectAppDelegate *delegate;
	IBOutlet UIButton *proxiBtn;
	NSMutableArray *proximitys;
	
	GKSession *currentSession;
	GKPeerPickerController *picker1;
	NSString *peerID1;
	NSData *myReceivedData;
	NSData *mySendData;
	IBOutlet UITextField *displayNameTxt;
}
@property(nonatomic,retain)	NSString *peerID1;
@property(nonatomic,retain)GKSession *currentSession;

-(IBAction)chooseProxiBtnClicked:(id)sender;
-(IBAction)scanBtnClicked:(id)sender;
-(void)getResult;

-(void)OpenLibrary:(int)choice;
- (void) mySendDataToPeers:(NSData *) data;
-(IBAction)btnSend:(id)sender;
-(NSString*)dataFilePath:(NSString*) name;
-(void)receiveData:(NSData*)data;
-(void)sendMessage;
@end

