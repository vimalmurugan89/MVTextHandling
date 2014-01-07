//
//  MVTextExtractor.m
//  TextExtractor
//
//  Created by admin on 07/01/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "MVTextExtractor.h"

@interface MVTextExtractor()
@property(nonatomic,strong)NSString *paragraphString;
@end

@implementation MVTextExtractor


#pragma mark -Singleton method
+(id)sharedExtractor{
    static dispatch_once_t once;
    static MVTextExtractor *textExtractor;
    dispatch_once(&once, ^{
        textExtractor = [[self alloc] init];
        
    });
    return textExtractor;
}

#pragma mark -Initializer Methods
-(void)setText:(NSString*)text{
   
    _paragraphString=text; //Assign original string to class insatnce
}

-(void)setTextPath:(NSString*)textPath{
    
    NSError *error;//Define error value
    NSString *text=[NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:&error];//Read text from given file path
    if (error) {//if any error
        NSLog(@"Error while reading %@",[error localizedDescription]);//Throw error and return
        return;
    }
    _paragraphString=text; //Assign original string to class insatnce
}

#pragma mark -
-(void)numberOfLines:(ProcessSuccess)success failure:(ProcessFailure)failure{
    
    if(_paragraphString==nil){
        failure(@"No string avialbale for get number of lines");//Throw string is empty
        return;
    }
    
    NSArray *textArray=[_paragraphString componentsSeparatedByString:@"\n"];//Split into array by '\n' character
    success([NSNumber numberWithInt:[textArray count]]);//Throw array count
}

-(void)numberOfCharacter:(ProcessSuccess)success failure:(ProcessFailure)failure{
    if(_paragraphString==nil){
        failure(@"No string avialbale for get number of character");//Throw string is empty
        return;
    }
    
    success([NSNumber numberWithInt:[_paragraphString length]]);//Throw string length
}

@end
