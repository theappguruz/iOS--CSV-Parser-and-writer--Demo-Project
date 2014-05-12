//
//  ViewController.m
//  SampleProject
//
//  Created by TheAppGuruz-New-6 on 06/05/14.
//  Copyright (c) 2014 TheAppGuruz-New-6. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary *dict;
    NSMutableArray *currentRow;
}
@synthesize txtMarks,txtName,txtRno;
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) parserDidBeginDocument:(CHCSVParser *)parser
{
    currentRow = [[NSMutableArray alloc] init];
}

-(void) parserDidEndDocument:(CHCSVParser *)parser
{
    for(int i=0;i<[currentRow count];i++)
    {
        NSLog(@"%@          %@          %@",[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]],[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"2"]]);
    }
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Parser failed with error: %@ %@", [error localizedDescription], [error userInfo]);
}

-(void)parser:(CHCSVParser *)parser didBeginLine:(NSUInteger)recordNumber
{
    dict=[[NSMutableDictionary alloc]init];
}

-(void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    [dict setObject:field forKey:[NSString stringWithFormat:@"%d",fieldIndex]];
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber
{
    [currentRow addObject:dict];
    dict=nil;
}


- (IBAction)btnWrite:(id)sender
{
    CHCSVParser *parser=[[CHCSVParser alloc] initWithContentsOfCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"demo.csv"] delimiter:','];
    parser.delegate=self;
    [parser parse];
    
    CHCSVWriter *csvWriter=[[CHCSVWriter alloc]initForWritingToCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"demo.csv"]];
    NSLog(@"%d",[currentRow count]);
    
    [csvWriter writeField:@"Roll Number"];
    [csvWriter writeField:@"Name"];
    [csvWriter writeField:@"Marks"];
    [csvWriter finishLine];
    
    for(int i=1;i<[currentRow count];i++)
    {
        [csvWriter writeField:[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]]];
        [csvWriter writeField:[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]]];
        [csvWriter writeField:[[currentRow objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"2"]]];
        [csvWriter finishLine];
    }
    [csvWriter writeField:[txtRno text]];
    [csvWriter writeField:[txtName text]];
    [csvWriter writeField:[txtMarks text]];


    
    [csvWriter closeStream];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Success" message:@"Your data has been successfully saved." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alert show];
    
    txtRno.text=@"";
    txtName.text=@"";
    txtMarks.text=@"";
}

- (IBAction)btnDismissKeyboardClicked:(id)sender
{
    [txtRno resignFirstResponder];
    [txtName resignFirstResponder];
    [txtMarks resignFirstResponder];
}
@end
