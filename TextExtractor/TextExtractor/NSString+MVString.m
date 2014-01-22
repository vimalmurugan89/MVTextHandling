//
//  NSString+MVString.m
//  TextExtractor
//
//  Created by admin on 07/01/14.
//  Copyright (c) 2014 admin. All rights reserved.
//

#import "NSString+MVString.h"

@implementation NSString (MVString)
-(NSUInteger)numberOfLines{
    NSArray *textArray=[self componentsSeparatedByString:@"\n"];
    return [textArray count];
}
-(NSUInteger)numberOfCharacter{
    return [self length];
}
-(NSString*)alignParagraph{
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"([a-z])([A-Z])" options:0 error:NULL];
    return [regexp stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@"$1 $2"];
}
-(NSUInteger)numberOfUpperCaseCharacter{
    return [[[self componentsSeparatedByCharactersInSet:[[NSCharacterSet uppercaseLetterCharacterSet] invertedSet]] componentsJoinedByString:@""] length];
}
-(NSUInteger)numberOfLowerCaseCharacter{
    return [self length]-[self numberOfUpperCaseCharacter];
}

-(NSUInteger)numberOfWord{
    NSArray *textArray=[self componentsSeparatedByString:@" "];
    return [textArray count];
}
-(NSString*)language{
    if (self.length < 100) {
    return (NSString *)CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0, self.length)));
    } else {
        
    return (NSString *)CFBridgingRelease(CFStringTokenizerCopyBestStringLanguage((CFStringRef)self, CFRangeMake(0,100)));
    }
}
-(NSUInteger)numberOfOccurenceOfWord:(NSString*)word{
    NSUInteger count = 0, length = [self length];
    NSRange range = NSMakeRange(0, length);
    while(range.location != NSNotFound)
    {
        range = [self rangeOfString:word options:0 range:range];
        if(range.location != NSNotFound)
        {
            range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            count++; 
        }
    }
    return count;
}
-(NSUInteger)numberCorrectSpelledWord{
    NSArray* words = [self componentsSeparatedByString:@" "];
    NSInteger wordsFound = 0;
    UITextChecker* checker = [[UITextChecker alloc] init];
    NSString* preferredLang = [[UITextChecker availableLanguages] objectAtIndex:0];
    
    //for each word in the array, determine whether it is a valid word
    for(NSString* currentWord in words){
        NSRange range;
        range = [checker rangeOfMisspelledWordInString:currentWord
                                                 range:NSMakeRange(0, [currentWord length])
                                            startingAt:0
                                                  wrap:NO
                                              language:preferredLang];
        //if it is valid (no errors found), increment wordsFound
        if (range.location == NSNotFound) {
            wordsFound++;
        }
       //Application supports iTunes file sharing
    }
    return wordsFound;
}
-(NSUInteger)numberNonCorrectSpelledWord{
    return [self numberOfWord]-[self numberCorrectSpelledWord];
}

-(NSArray*)listOfPhoneNumber{
    NSMutableArray *phoneNumberArray=[NSMutableArray array];
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber
                                                               error:nil];
    NSArray *matches=[detector matchesInString:self
                             options:0
                               range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypePhoneNumber) {
            [phoneNumberArray addObject:[match phoneNumber]];
           
        }
    }
    
    return phoneNumberArray;
    
}
-(NSArray*)listOfMailId{

    NSMutableArray *mailIdArray=[NSMutableArray array];
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:nil];
    NSArray *matches=[detector matchesInString:self
                                       options:0
                                         range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        if ([match resultType] == NSTextCheckingTypeLink) {
            [mailIdArray addObject:[match phoneNumber]];
            
        }
    }
    
    return mailIdArray;
}

//Actions
-(NSString*)removeWhiteSpaceAtEnd{
   return [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
}
-(NSString*)removeNewLineCharacter{
    return [self stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
}
-(NSString*)removeWhiteSpaceAndNewline{
   return [self stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
-(NSString*)getInbetweenString:(NSString*)separator{
    NSRange firstInstance = [self rangeOfString:separator];
    NSRange secondInstance = [[self substringFromIndex:firstInstance.location + firstInstance.length] rangeOfString:separator];
    NSRange finalRange = NSMakeRange(firstInstance.location + separator.length, secondInstance.location);
    
    return [self substringWithRange:finalRange];
}
-(NSString*)substringFromString:(NSString*)string{
    NSRange range = [self rangeOfString:string];
   return [[self substringFromIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString*)substringToString:(NSString*)string{
    NSRange range = [self rangeOfString:string];
    return [[self substringToIndex:NSMaxRange(range)] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(NSString*)mergeString:(NSString*)value{
    return [self stringByAppendingString:value];
}

//checking
-(BOOL)isNULLOrEmpty{
    if (!self||[self isKindOfClass:[NSNull class]]||[self length]==0) {
        return YES;
    }
    return NO;
}
-(BOOL)isNumber{
    
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:self];
    return [alphaNumbersSet isSupersetOfSet:stringSet];
 
}
-(BOOL)isAvailableWord:(NSString*)word{
    NSArray *textArray=[self componentsSeparatedByString:@" "];
    return [textArray containsObject:word];
}
-(BOOL)isPalindrome{
   
    NSInteger length = self.length;
    
    NSInteger halfLength = length / 2;
    
    __block BOOL isPalindrome = YES;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, halfLength) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        NSRange otherRange = [self rangeOfComposedCharacterSequenceAtIndex:length - enclosingRange.location - 1];
        
        if (![substring isEqualToString:[self substringWithRange:otherRange]]) {
            isPalindrome = NO;
            *stop = YES;
        }
    }];
    return isPalindrome;
}
-(BOOL)isMailId{
  
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:nil];
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:self
                                                           options:0
                                                             range:NSMakeRange(0, [self length])];
    if (numberOfMatches>0) {
        return YES;
    }
    return NO;
    
}
-(BOOL)isPhoneNumber{
   
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypePhoneNumber
                                                               error:nil];
    NSUInteger numberOfMatches = [detector numberOfMatchesInString:self
                                                           options:0
                                                             range:NSMakeRange(0, [self length])];
    if (numberOfMatches>0) {
        return YES;
    }
    return NO;
}
-(BOOL)isURL{
    if ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]){
        return YES;
    }
    return NO;
}

//conversions
-(NSData*)data{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}
-(NSURL*)url{
    if ([self isURL]){
        return [NSURL URLWithString:self];
    }
    return [NSURL fileURLWithPath:self];
}
-(NSDate*)dateWithFormatter:(NSDateFormatter*)formatter{
    if (formatter==nil) {
        return nil;
    }
    return [formatter dateFromString:self];
}

@end
