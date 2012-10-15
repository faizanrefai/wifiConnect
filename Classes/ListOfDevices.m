//
//  ListOfDevices.m
//  wifiConnect
//
//  Created by apple on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListOfDevices.h"


@implementation ListOfDevices

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
	listOfDevice=[[NSMutableArray alloc] initWithObjects:@"sunil",@"jayneel",@"darshan",@"openxcell",nil];
	[myTable reloadData];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return [listOfDevice count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[listOfDevice objectAtIndex:indexPath.row]];
    // Configure the cell...
  
    
    return cell;
	
	
}	


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UIActionSheet *alert = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Send file" otherButtonTitles:nil];
	[alert showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if (buttonIndex==0) {
		NSLog(@"sunil");
		[self OpenLibrary];
	}
}

-(void)OpenLibrary{
	UIImagePickerController *picker1;
	picker1 = [[UIImagePickerController alloc]init];
	picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker1.delegate = self;
	[self presentModalViewController:picker1 animated:YES];	
	[picker1 release];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	
	[picker dismissModalViewControllerAnimated:NO];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
	
	
		UIImage *image =[[UIImage alloc] init];
		image = [info objectForKey:UIImagePickerControllerOriginalImage];
		
		NSData *dt = UIImageJPEGRepresentation(image, 0.2);
		image = [UIImage imageWithData:dt];
		//image =[image resizedImage:CGSizeMake(291, 291) interpolationQuality:0.1];
		
		[picker dismissModalViewControllerAnimated:NO];

	dataSentResult *sent = [[dataSentResult alloc] initWithNibName:nil bundle:nil];
	[self.navigationController  pushViewController:sent animated:YES];
	
		
		
		
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
