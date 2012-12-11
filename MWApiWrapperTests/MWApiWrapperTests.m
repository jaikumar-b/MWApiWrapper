//
//  MWApiWrapperTests.m
//  MWApiWrapperTests
//
//  Created by Jaikumar Bhambhwani on 12/2/12.
//  Copyright (c) 2012 WikiMedia. All rights reserved.
//

#import "MWApiWrapperTests.h"
#import <mwapi/NSString+Extras.h>
#import <mwapi/MWApiMultipartRequestBuilder.h>

@implementation MWApiWrapperTests

- (void)setUp
{
    [super setUp];
    apiURL = [NSURL URLWithString:@"http://localhost:8888/mediawiki/api.php"];
    mwapi = [[MWApi alloc] initWithApiUrl:apiURL];
}

- (void)tearDown
{
    [super tearDown];
}

-(void)testUpload
{
    STAssertTrue([[mwapi loginWithUsername:@"jasoncigar" andPassword:@"Wiki123" withCookiePersistence:YES] isEqualToString:@"Success"],nil);
    NSString *filepath  = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"png"];
    MWApiResult *result = [mwapi uploadFile:@"test" withFilepath:filepath text:@"Wohhh its working!" comment:@"Just another image"];
    STAssertTrue([[result getStringWithXpath:@"/api/upload/@result"] isEqualToString:@"Success"],nil);
    STAssertTrue([[NSString sha1:filepath isFile:YES] isEqualToString:[result getStringWithXpath:@"/api/upload/imageinfo/@sha1"]],nil);
}

@end
