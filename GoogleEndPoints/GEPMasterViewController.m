//
//  GEPMasterViewController.m
//  GoogleEndPoints
//
//  Created by mihata on 11/22/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) //1

#define kBeersURL [NSURL URLWithString:@"https://demos-biira.appspot.com/_ah/api/birra/v1/beer?fields=items(beerName%2Ccountry%2Cdescription%2Cid%2CkindOfBeer%2Clatitude%2Clongitude%2CnumberOfDrinks%2Cscore)"]

#import "GEPMasterViewController.h"

#import "GEPDetailViewController.h"

@interface GEPMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation GEPMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _rawData = [[NSArray alloc] init];
    _filteredData = [[NSMutableArray alloc] init];
    
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_async(kBgQueue, ^{
        //        NSData* data = [NSData dataWithContentsOfURL:kLatestKivaLoansURL];
        NSData* data = [NSData dataWithContentsOfURL:kBeersURL];
        
        //        jsonSummary.text = @"Wait...";
        [self performSelectorOnMainThread:@selector(fetchedBeers:) withObject:data waitUntilDone:YES];
        //        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchedBeers : (NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    
    
    _rawData = [json objectForKey:@"items"];
    
    for (NSDictionary* beerObject in _rawData) {
        NSString* beerName = [beerObject objectForKey:@"beerName"];
        if (beerName != nil) {
            [_filteredData addObject:beerObject];
        }
    }
    
    [self.tableView reloadData];
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
