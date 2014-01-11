//
//  ViewController.m
//  fruitsBuy
//
//  Created by Joe437 on 2013/12/20.
//  Copyright (c) 2013年 Joe437. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
-(IBAction)dismissNext:(UIStoryboardSegue *)segue{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    
    self.myTextView.text=@"";
    self.myTextView.editable=NO;
    
    NSURL *myURL=[NSURL URLWithString:@"http://10.211.55.4/search/"];
    NSXMLParser *myParser=[[NSXMLParser alloc]initWithContentsOfURL:myURL];
    
    myParser.delegate=self;
    
    [myParser parse];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    nowTagStr=[NSString stringWithString:@""];
    
}

-(void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"li"]) {
        nowTagStr=[NSString stringWithString:elementName];
        txtBuffer=[NSString stringWithString:@""];
    }
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    
    if ([nowTagStr isEqualToString:@"li"]) {
        txtBuffer=[txtBuffer stringByAppendingString:string];
    }
}
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    
    if ([elementName isEqualToString:@"li"]) {
        self.myTextView.text=[self.myTextView.text stringByAppendingFormat:@"\n找到: %@ \n",txtBuffer];
    }
    
}


        
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchFruits:(id)sender {
}
- (IBAction)orderingButton:(id)sender {
    
    [self.view endEditing:YES];
    
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:@"訂單已送出" message:@"請按確定" delegate:nil cancelButtonTitle:@"確定" otherButtonTitles:nil, nil];
    [alertView show];

    
    NSMutableURLRequest *myURLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://10.211.55.4/ordering/"]];
    
    
    NSString  *orderNameInput=self.nameTextField.text;
    NSString  *orderEmailInput=self.emailTextField.text;
    NSString  *orderFruitInput=self.fruitTextField.text;
    NSString  *orderQuantityInput=self.quantityTextField.text;
    NSString *orderPayInput=self.payTextField.text;
    
    
    NSString *orderSTring = [NSString stringWithFormat:@"name=%@&email=%@&fruits=%@&quantity=%@&pay=%@",orderNameInput,orderEmailInput,orderFruitInput,orderQuantityInput,orderPayInput];    myURLReq.HTTPMethod = @"post";
    
    NSData *body = [orderSTring dataUsingEncoding:NSUTF8StringEncoding];
    myURLReq.HTTPBody = body;
    
    [NSURLConnection sendAsynchronousRequest:myURLReq queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *nameData, NSError *connectionError) {
        NSLog(@"result %@", [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding]);
    }];
}

- (IBAction)searchFruitsButton:(id)sender {
    [self.view endEditing:YES]; //加了這段鍵盤打完會縮下去
    
    NSString *searchInput=self.searchFruitsTextField.text;
    
    NSString * queryString = [NSString stringWithFormat:@"q=%@",searchInput];
    NSString *url  = [@"http://10.211.55.4/search?" stringByAppendingString:queryString];
    NSMutableURLRequest *myURLReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    myURLReq.HTTPMethod = @"get";
//    NSString * bodyString = @"name=aaa&email=xxx&...";
//    NSData * data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
//    myURLReq.HTTPBody = data;
    [NSURLConnection sendAsynchronousRequest:myURLReq queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"result %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSXMLParser *myParser=[[NSXMLParser alloc]initWithData:data];
        
        myParser.delegate=self;
        
        [myParser parse];
        
    }];


    
}
@end
