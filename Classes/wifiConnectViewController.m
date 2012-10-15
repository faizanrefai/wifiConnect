//
//  wifiConnectViewController.m
//  wifiConnect
//
//  Created by apple on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "wifiConnectViewController.h"
#define kTankSessionID @"wli"

@implementation wifiConnectViewController
@synthesize currentSession;
@synthesize peerID1;


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachePath = [paths objectAtIndex:0];
	NSLog(@"%@",cachePath);
	
	proximitys =[[NSMutableArray alloc] initWithObjects:@"1",@"5",@"10",@"20",@"30",@"40",@"50",@"60",@"70",@"80",nil];
}


- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != nil) {
        NSLog(@"Error: %@", error);
    }
}


-(NSString *) participantID
{
    return currentSession.peerID;
}

-(void) voiceChatService:(GKVoiceChatService *) voiceChatService
                sendData:(NSData *) data
         toParticipantID:(NSString *)participantID {
	
    [currentSession sendData:data toPeers:
	 [NSArray arrayWithObject:participantID] 
				withDataMode:GKSendDataReliable error:nil];
	
}
/*
- (void)session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state {
	
    switch (state)
    {
        case GKPeerStateConnected:
        {            
            //---plays an audio file---
            NSString *soundFilePath = [[NSBundle mainBundle] 
									   pathForResource:@"1" ofType:@"wav"];
			
            NSURL *fileURL = [[NSURL alloc] 
							  initFileURLWithPath: soundFilePath];
			
            AVAudioPlayer *audioPlayer =
			[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL 
												   error:nil];
			
            [fileURL release];
            [audioPlayer play];            
            
            NSError *error;
            AVAudioSession *audioSession = 
			[AVAudioSession sharedInstance];
			
            if (![audioSession  
				  setCategory:AVAudioSessionCategoryPlayAndRecord 
				  error:&error]) {
                NSLog(@"Error setting the AVAudioSessionCategoryPlayAndRecord category: %@", 
					  [error localizedDescription]);
            }
            
            if (![audioSession setActive: YES error: &error]) {
                NSLog(@"Error activating audioSession: %@", 
					  [error description]);
            }
            
            [GKVoiceChatService defaultVoiceChatService].client = self;
            
            //---initiating the voice chat---
            if (![[GKVoiceChatService defaultVoiceChatService] 
				  startVoiceChatWithParticipantID:peerID error:&error]) {
                NSLog(@"Error starting startVoiceChatWithParticipantID: %@", 
					  [error userInfo]);
            }
        } break;
            
        case GKPeerStateDisconnected:
        {
            [[GKVoiceChatService defaultVoiceChatService] 
			 stopVoiceChatWithParticipantID:peerID];
            
            [self.currentSession release];
            currentSession = nil;        
            
            
			
        } break;
    }
}

*/

-(IBAction)chooseProxiBtnClicked:(id)sender{
/*	actionSheet1 = [[UIActionSheet alloc]
					initWithTitle:@"Select Proximity:\n\n\n\n\n\n\n\n\n\n\n\n\n"
					delegate:self
					cancelButtonTitle:@"Select"
					destructiveButtonTitle:nil
					otherButtonTitles:nil];
	
	[actionSheet1 showInView:self.view];
	actionSheet1.actionSheetStyle = UIActionSheetStyleDefault;
	[actionSheet1 showInView:self.view];
	actionSheet1.opaque=YES;
	actionSheet1.backgroundColor=[UIColor clearColor];
	CGRect pickerFrame = CGRectMake(0,35,0,0);
	
	picker1 = [[UIPickerView alloc] initWithFrame:pickerFrame];
	
	picker1.backgroundColor = [UIColor clearColor];
	picker1.autoresizesSubviews;
	picker1.delegate =self;
	picker1.showsSelectionIndicator =YES;
	[picker1 selectRow:2 inComponent:0 animated:YES];
	[actionSheet1 addSubview:picker1];
	*/
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return [proximitys count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	
	return [NSString stringWithFormat:@"%@",[proximitys objectAtIndex:row]];

}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
}	

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	
	if (buttonIndex==0) {
		[proxiBtn setTitle:[NSString stringWithFormat:[proximitys objectAtIndex:[picker1 selectedRowInComponent:0]]] forState:UIControlStateNormal];
		
	}
}

#pragma mark -
#pragma mark Connect

-(IBAction)scanBtnClicked:(id)sender{
	
	/*
	delegate = (wifiConnectAppDelegate*)[[UIApplication sharedApplication] delegate];
	[delegate doshowLoadingView];
	[self performSelector:@selector(getResult) withObject:nil afterDelay:5];

	
	picker1 = [[GKPeerPickerController alloc] init]; 
	picker1.delegate = self;    
//	picker1.connectionTypesMask =  (GKPeerPickerConnectionTypeOnline  );
	[picker1 show];
		*/
	
	currentSession = [[GKSession alloc] initWithSessionID:nil displayName:nil sessionMode:GKSessionModePeer];
	currentSession.delegate = self;
	currentSession.available = YES;
	currentSession.disconnectTimeout = 0;
	
	// Set data handler.
	[currentSession setDataReceiveHandler:self withContext:nil];
	
	NSLog(@"%@",[currentSession peersWithConnectionState:GKPeerStateAvailable]);
	
}
/*
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type { 
	currentSession = [[GKSession alloc] initWithSessionID:kTankSessionID displayName:displayNameTxt.text sessionMode:GKSessionModePeer]; 
	currentSession.delegate = self;
	[currentSession peersWithConnectionState:GKPeerStateAvailable];
	return currentSession; // peer picker retains a reference, so autorelease ours so we don't leak.
}
*/
- (void)session:(GKSession*) session didReceiveConnectionRequestFromPeer:(NSString*) peerID {
	
    [session acceptConnectionFromPeer:peerID error:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[displayNameTxt resignFirstResponder];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type {
    NSLog(@"Selecte any option");
	if (type == GKPeerPickerConnectionTypeOnline) {     
		NSLog(@"Online option selected");	
		
		NSLog(@"Call Bonjour");	
		[picker dismiss];
		[picker release];
	}
	else {
		
		//NSLog(@"NearBy option selected");
	}
	
}
- (void)peerPickerController:(GKPeerPickerController *)picker 
              didConnectPeer:(NSString *)peerID 
                   toSession:(GKSession *) session {
	self.peerID1=peerID;
	self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
	picker.delegate = nil;
	
    [picker dismiss];
    [picker autorelease];
	
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state {
	self.currentSession = session;
	
	// Do stuff depending on state.
	switch (state) {
		case GKPeerStateAvailable:
			[session connectToPeer:peerID withTimeout:0];
			break;
	}
	
}
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    picker.delegate = nil;
    [picker autorelease];
	
}


#pragma mark -
#pragma mark Send Data

-(IBAction)btnSend:(id)sender
{
	//[picker1 dismiss];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"choose file" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"Image",@"Video",@"Message",@"Cancel",nil];
	alert.delegate=self;
	alert.tag=0;
	[alert show];
	
//	NSString *st = [NSString stringWithString:@"sunil"];
	
//	[self mySendDataToPeers:[st dataUsingEncoding:NSASCIIStringEncoding]];
		
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
if (alertView.tag==1) {

	switch (buttonIndex) {
		case 0:
			[self receiveData:myReceivedData];
			break;
		case 1:
			
			break;
			
		default:
			break;
	}
	
}if (alertView.tag==2) {

	switch (buttonIndex) {
		case 0:{

			UITextField *txt = (UITextField*)[alertView viewWithTag:11];
			NSString *str = [NSString stringWithFormat:@"%@",[txt text]];
			NSLog(@"%@",str);
			mySendData = [[NSData alloc] initWithData:[str dataUsingEncoding: NSASCIIStringEncoding]]; 
			 
			[self sendMessage];
			
			}
			break;
		case 1:
			
			break;
		default:
			break;
	}
	

}if (alertView.tag==3) {

	switch (buttonIndex) {
		case 0:
			[self OpenLibrary:2];
			break;
		case 1:
		
			break;
		
		default:
			break;
	}
	
	
	
}else if(alertView.tag==0){
	switch (buttonIndex) {
		case 0:
			[self OpenLibrary:0];
			break;
		case 1:
			[self OpenLibrary:1];
			break;
		case 2:
			[self OpenLibrary:2];
			break;
			
		default:
			break;
	}
	
}
	
}
- (void) mySendDataToPeers:(NSData *) data
{
    if (currentSession) 
		[currentSession sendData:data toPeers:[NSArray arrayWithObject:peerID1] withDataMode:GKSendDataReliable error:nil];
	
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error{

	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] ;
	[alert show];
}
-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void *)context{
	
	
    //---convert the NSData to NSString---
	
	
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	NSDictionary *dic = [[NSDictionary alloc] init];
	dic= [unarchiver decodeObjectForKey:@"mykey"];

	if ([dic valueForKey:@"msg"]) {
		[self receiveData:data];
	}else {
		myReceivedData=[[NSData alloc] initWithData:data];
		NSString *msg = [[NSString alloc] initWithFormat:@"%@ want to send you file",session.displayName];
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Data Received" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"Accept",@"Reject",nil] ;
		alert.tag=1;
		[alert show];
		
	}

	
	
  
	
}

-(void)receiveData:(NSData*)data{
	NSString* str;
	
    //str = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    //UIImageView	*imgV= [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
	NSDictionary *dic = [[NSDictionary alloc] init];
	dic= [unarchiver decodeObjectForKey:@"mykey"];
	
	LibraryViewController *lib;
	if ([dic valueForKey:@"image"]) {
		//UIImageView	*imgV= [[UIImageView alloc] initWithImage:[UIImage imageWithData:[dic objectForKey:@"image"]]];
		//[self.view addSubview:imgV];
		lib = [[LibraryViewController alloc] initWithNibName:nil bundle:nil];
		lib.isType=0;
		lib.ReceiveData=[dic objectForKey:@"image"];
		[self presentModalViewController:lib animated:YES];
		
		
	}else if([dic valueForKey:@"video"]) {
		
		lib = [[LibraryViewController alloc] initWithNibName:nil bundle:nil];
		lib.isType=1;
		
		lib.ReceiveData=[[NSData alloc] initWithData:[dic objectForKey:@"video"]];
		
		
		[self presentModalViewController:lib animated:YES];
		
		
	}else if([dic valueForKey:@"msg"]) {
		NSString* str;
		str = [[NSString alloc] initWithData:[dic objectForKey:@"msg"] encoding:NSASCIIStringEncoding];    
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message received" 
														message:str 
													   delegate:self 
											  cancelButtonTitle:nil 
											  otherButtonTitles:@"Reply",@"Cancel",nil];
		alert.tag=3;
		[alert show];
		
		
	}
	
	[unarchiver finishDecoding];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	
	[picker dismissModalViewControllerAnimated:NO];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	
if ([[info valueForKey:UIImagePickerControllerMediaType] isEqual:@"public.image"]) {	
	UIImage *image =[[UIImage alloc] init];
	image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	NSData *dt = UIImageJPEGRepresentation(image, 0.2);
	image = [UIImage imageWithData:dt];
	//image =[image resizedImage:CGSizeMake(291, 291) interpolationQuality:0.1];
	
	[picker dismissModalViewControllerAnimated:NO];
	
	
	NSData *data = UIImageJPEGRepresentation(image, 1.0);
	NSDictionary *myDic = [[NSDictionary alloc] initWithObjectsAndKeys:data,@"image",nil];
	
	NSMutableData *data1 = [[NSMutableData alloc]init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
	[archiver encodeObject:myDic forKey:@"mykey"];
	[archiver finishEncoding];
	
	[data1 writeToFile:[self dataFilePath:@"path"] atomically:YES];
	
	[archiver release];
	
	[self.currentSession sendData:data1 toPeers:[NSArray arrayWithObject:peerID1] withDataMode:GKSendDataReliable error:nil];
	
}else {
	NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
	NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
	[picker dismissModalViewControllerAnimated:NO];
	
	
	NSDictionary *myDic = [[NSDictionary alloc] initWithObjectsAndKeys:videoData,@"video",nil];
	
	NSMutableData *data1 = [[NSMutableData alloc]init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
	[archiver encodeObject:myDic forKey:@"mykey"];
	[archiver finishEncoding];
	
	[data1 writeToFile:[self dataFilePath:@"path"] atomically:YES];
	
	[archiver release];
	
	[self.currentSession sendData:data1 toPeers:[NSArray arrayWithObject:peerID1] withDataMode:GKSendDataReliable error:nil];
	
	
	
}

	
}


-(void)OpenLibrary:(int)choice{
	
	if (choice != 2) {

	
		UIImagePickerController *imagePicker;
		imagePicker = [[UIImagePickerController alloc]init];
		imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
		
		if (choice) {
			imagePicker.mediaTypes =  [NSArray arrayWithObject:(NSString *)kUTTypeMovie];		
		}

		
		imagePicker.delegate = self;
		[self presentModalViewController:imagePicker animated:YES];	
		[imagePicker release];
		
	}else {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Type Message" message:@"\n\n\n" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Send",@"Cancel",nil];
		
		UITextField *textV=[[UITextField alloc]initWithFrame:CGRectMake(10, 80, 260, 36)];
		[textV setBackgroundColor:[UIColor colorWithWhite:0.8 alpha:0.8]];
		textV.textAlignment=UITextAlignmentCenter;
		textV.textColor=[UIColor blackColor];
		textV.font=[UIFont fontWithName:@"Helvetica" size:21];
	
		textV.tag=11;
		alert.delegate=self;
		[alert addSubview:textV];
		
		alert.tag=2;
		[alert show];		
		
	}

}
-(void)sendMessage{
	
	
	NSDictionary *myDic = [[NSDictionary alloc] initWithObjectsAndKeys:mySendData,@"msg",nil];
	
	NSMutableData *data1 = [[NSMutableData alloc]init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data1];
	[archiver encodeObject:myDic forKey:@"mykey"];
	[archiver finishEncoding];
	
	[data1 writeToFile:[self dataFilePath:@"path"] atomically:YES];
	
	[currentSession sendData:data1 toPeers:[NSArray arrayWithObject:peerID1] withDataMode:GKSendDataUnreliable error:nil];

}

-(NSString*)dataFilePath:(NSString*) name
{
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) 
			 objectAtIndex:0] stringByAppendingPathComponent:name];
}
-(void)showLoadding{
	
}
-(void)getResult{
	[delegate dohideLoadingView];
	ListOfDevices *list = [[ListOfDevices alloc] initWithNibName:nil bundle:nil];
	[self.navigationController pushViewController:list animated:YES];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
