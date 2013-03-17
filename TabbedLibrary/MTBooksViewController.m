//
//  MTBooksViewController.m
//  Library
//
//  Created by James Cryer on 17/03/2013.
//  Copyright (c) 2013 James Cryer. All rights reserved.
//

#import "MTBooksViewController.h"

#import "MTBookCoverViewController.h"

@interface MTBooksViewController ()

@property NSArray *books;

@end

@implementation MTBooksViewController


#pragma mark -
#pragma mark View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Getters and Setters
- (void)setAuthor:(NSString *)author
{
    if (_author != author) {
        _author = author;
        
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Books" ofType:@"plist"];
        NSArray *authors = [NSArray arrayWithContentsOfFile:filePath];
        
        for (int i = 0; i < [authors count]; i++) {
            NSDictionary *authorDictionary = [authors objectAtIndex:i];
            NSString *tempAuthor = [authorDictionary objectForKey:@"Author"];
            
            if ([tempAuthor isEqualToString:_author]) {
                self.books = [authorDictionary objectForKey:@"Books"];
            }
        }
    }
}

#pragma mark -
#pragma mark Table View Data Source Methods
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
    
    // Fetch Books
    NSDictionary *book = [self.books objectAtIndex:[indexPath row]];
    
    // Configure Cell
    [cell.textLabel setText:[book objectForKey:@"Title"]];
    
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"displayBook" sender:self];
}

#pragma mark -
#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"displayBook"]) {
        NSDictionary *book = [self.books objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        UIImage *bookCover = [UIImage imageNamed:[book objectForKey:@"Cover"]];
        
        MTBookCoverViewController *bcvc = [segue destinationViewController];
        [bcvc setBookCover:bookCover];
    }
}

@end
