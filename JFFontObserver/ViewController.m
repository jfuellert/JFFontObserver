//
//  ViewController.m
//  JFFontObserver
//
//  Created by Jeremy Fuellert on 2015-09-11.
//  Copyright (c) 2015 Jeremy Fuellert. All rights reserved.
//

#import "JFFontObserver.h"
#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Add font observer
    typeof(self) __weak weakSelf = self;
    [JFFontObserver addObserver:self fontUpdateBlock:^{
 
        weakSelf.label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        
    } updateImmediatly:YES];
}

#pragma mark - Dealloc
- (void)dealloc {
    
    [JFFontObserver removeObserver:self];
}

@end