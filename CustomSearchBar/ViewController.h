//
//  ViewController.h
//  CustomSearchBar
//
//  Created by iceboxi on 2016/1/18.
//  Copyright © 2016年 iceboxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *theTableView;

@end

