//
//  MVTextExtractor.h
//  TextExtractor
//
//  Created by admin on 07/01/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ProcessSuccess)(id response);
typedef void (^ProcessFailure)(NSString *error);

@interface MVTextExtractor : NSObject

+(id)sharedExtractor;//Singleton method
-(void)setText:(NSString*)text;//Set text to global value
-(void)setTextPath:(NSString*)textPath;//Read text from given path
-(void)numberOfLines:(ProcessSuccess)success failure:(ProcessFailure)failure;//Get number of lines
-(void)numberOfCharacter:(ProcessSuccess)success failure:(ProcessFailure)failure;//Get number of characters

@end
