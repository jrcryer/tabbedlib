//
//  MTAuthorsViewController.m
//  Library
//
//  Created by James Cryer on 17/03/2013.
//  Copyright (c) 2013 James Cryer. All rights reserved.
//

#import "MTAuthorsViewController.h"

#import "MTBooksViewController.h"

@interface MTAuthorsViewController ()

@end

@implementation MTAuthorsViewController

#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Authors";
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
    self.authors = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"authors > %@", self.authors);
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.authors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *author = [self.authors objectAtIndex:[indexPath row]];
    
    [cell.textLabel setText:[author objectForKey:@"Author"]];
    
    return cell;
}


#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"displayBooks" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"displayBooks"]) {
        // Initialize Books View Controller
        MTBooksViewController *booksViewController = [segue destinationViewController];
        
        // Fetch and Set Author
        NSDictionary *author = [self.authors objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        [booksViewController setAuthor:[author objectForKey:@"Author"]];
    }
}

@end
