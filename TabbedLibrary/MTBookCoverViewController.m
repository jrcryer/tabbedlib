//
//  MTBookCoverViewController.m
//  Library
//
//  Created by James Cryer on 17/03/2013.
//  Copyright (c) 2013 James Cryer. All rights reserved.
//

#import "MTBookCoverViewController.h"

@interface MTBookCoverViewController ()

@end

@implementation MTBookCoverViewController

#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.bookCover) {
        [self.bookCoverView setImage:self.bookCover];
    }
}

@end
