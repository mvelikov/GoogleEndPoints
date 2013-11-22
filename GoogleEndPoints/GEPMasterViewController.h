//
//  GEPMasterViewController.h
//  GoogleEndPoints
//
//  Created by mihata on 11/22/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GEPMasterViewController : UITableViewController  <UITableViewDataSource>

@property (strong, nonatomic) NSArray *rawData;
@property (strong, nonatomic) NSMutableArray *filteredData;


@end
