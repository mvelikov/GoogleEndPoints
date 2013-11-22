//
//  GEPDetailViewController.m
//  GoogleEndPoints
//
//  Created by mihata on 11/22/13.
//  Copyright (c) 2013 mihata. All rights reserved.
//

#import "GEPDetailViewController.h"

@interface GEPDetailViewController ()
- (void)configureView;
@end

@implementation GEPDetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
//        self.score.text = [self.detailItem objectForKey:@"score"];
        self.beerName.text = [self.detailItem objectForKey:@"beerName"];
//        self.country.text = [self.detailItem objectForKey:@"country"];
//        self.description.text = [self.detailItem objectForKey:@"description"];        
//        self.kingOfBeer.text = [self.detailItem objectForKey:@"kingOfBeer"];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
