//
//  ListOfDevices.h
//  wifiConnect
//
//  Created by apple on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "dataSentResult.h"

@interface ListOfDevices : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate> {

	IBOutlet UITableView *myTable;
	NSMutableArray *listOfDevice;
}
-(void)OpenLibrary;
@end
