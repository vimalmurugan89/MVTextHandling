//
//  NSString+MVString.h
//  TextExtractor
//
//  Created by admin on 07/01/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MVString)
-(NSUInteger)numberOfLines;
-(NSUInteger)numberOfCharacter;
-(NSString*)alignParagraph;
-(NSUInteger)numberUpperCaseCharacter;
-(NSUInteger)numberOfLowerCaseCharacter;
-(BOOL)isAvailableWord:(NSString*)word;
-(NSUInteger)numberOfWord;
-(NSString*)language;
-(NSUInteger)numberOfOccurenceOfWord:(NSString*)word;
-(NSUInteger)numberCorrectSpelledWord;
-(NSUInteger)numberNonCorrectSpelledWord;
-(NSString*)trimStringFrom:(NSString*)character;
@end
