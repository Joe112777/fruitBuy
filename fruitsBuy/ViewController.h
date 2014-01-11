//
//  ViewController.h
//  fruitsBuy
//
//  Created by Joe437 on 2013/12/20.
//  Copyright (c) 2013年 Joe437. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>{
    NSString *nowTagStr;
    NSString *txtBuffer;
    
}

- (IBAction)orderingButton:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;

@property (weak, nonatomic) IBOutlet UITextField *fruitTextField;

@property (weak, nonatomic) IBOutlet UITextField *quantityTextField;


@property (weak, nonatomic) IBOutlet UITextField *payTextField;


- (IBAction)searchFruitsButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *searchFruitsTextField;

@property (weak, nonatomic) IBOutlet UITextView *myTextView;


@end
