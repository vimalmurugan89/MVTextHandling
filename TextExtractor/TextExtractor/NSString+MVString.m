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
-(NSUInteger)numberUpperCaseCharacter{
    return [[[self componentsSeparatedByCharactersInSet:[[NSCharacterSet uppercaseLetterCharacterSet] invertedSet]] componentsJoinedByString:@""] length];
}
-(NSUInteger)numberOfLowerCaseCharacter{
    return [self length]-[self numberUpperCaseCharacter];
}
-(BOOL)isAvailableWord:(NSString*)word{
    NSArray *textArray=[self componentsSeparatedByString:@" "];
    return [textArray containsObject:word];
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
       
    }
    return wordsFound;
}
-(NSUInteger)numberNonCorrectSpelledWord{
    return [self numberOfWord]-[self numberCorrectSpelledWord];
}

@end
