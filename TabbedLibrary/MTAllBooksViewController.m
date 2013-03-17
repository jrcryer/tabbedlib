//
//  MTAllBooksViewController.m
//  TabbedLibrary
//
//  Created by James Cryer on 17/03/2013.
//  Copyright (c) 2013 James Cryer. All rights reserved.
//

#import "MTAllBooksViewController.h"
#import "MTBookCoverViewController.h"

@interface MTAllBooksViewController ()

- (NSArray *)extractBooks;

@end

@implementation MTAllBooksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Books";
    
    self.books = [self extractBooks];
}

- (NSArray *)extractBooks {

    NSMutableArray *buffer = [[NSMutableArray alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
    NSArray *authors = [NSArray arrayWithContentsOfFile:filePath];
    
    for (int i = 0; i < [authors count]; i++) {
        NSDictionary *author = [authors objectAtIndex:i];

        [buffer addObjectsFromArray:[author objectForKey:@"Books"]];
    }
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"Title" ascending:YES];
    NSArray *result = [buffer sortedArrayUsingDescriptors:@[sortDescriptor]];
    return result;
}

#pragma mark -
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.books count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell Identifier";
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSDictionary *book = [self.books objectAtIndex:[indexPath row]];

    [cell.textLabel setText:[book objectForKey:@"Title"]];
    return cell;
}

#pragma mark -
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"displayBook" sender:self];
}

#pragma mark -
#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"displayBook"]) {
        NSDictionary *book = [self.books objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        UIImage *bookCover = [UIImage imageNamed:[book objectForKey:@"Cover"]];
        
        MTBookCoverViewController *bcvc = [segue destinationViewController];
        [bcvc setBookCover:bookCover];
    }
}

@end
