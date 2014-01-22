//
//  NSString+MVString.h
//  TextExtractor
//
//  Created by admin on 07/01/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MVString)

//text handling
-(NSUInteger)numberOfLines;
-(NSUInteger)numberOfCharacter;
-(NSString*)alignParagraph;
-(NSUInteger)numberOfUpperCaseCharacter;
-(NSUInteger)numberOfLowerCaseCharacter;
-(NSUInteger)numberOfWord;
-(NSString*)language;
-(NSUInteger)numberOfOccurenceOfWord:(NSString*)word;
-(NSUInteger)numberCorrectSpelledWord;
-(NSUInteger)numberNonCorrectSpelledWord;
-(NSArray*)listOfPhoneNumber;
-(NSArray*)listOfMailId;



//text actions
-(NSString*)removeWhiteSpaceAtEnd;
-(NSString*)removeNewLineCharacter;
-(NSString*)removeWhiteSpaceAndNewline;
-(NSString*)getInbetweenString:(NSString*)separator;
-(NSString*)substringFromString:(NSString*)string;
-(NSString*)substringToString:(NSString*)string;
-(NSString*)mergeString:(NSString*)value;

//checking
-(BOOL)isNULLOrEmpty;
-(BOOL)isNumber;
-(BOOL)isPalindrome;
-(BOOL)isAvailableWord:(NSString*)word;
-(BOOL)isMailId;
-(BOOL)isPhoneNumber;
-(BOOL)isURL;

//conversions
-(NSData*)data;
-(NSURL*)url;
-(NSDate*)dateWithFormatter:(NSDateFormatter*)formatter;








@end
