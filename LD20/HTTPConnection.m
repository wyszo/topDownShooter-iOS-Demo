//
//  HTTPConnectionDelegate.m
//  LD20
//
//  Created by tomek on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnection.h"
#import "Util.h"
#import "Crypto.h"


@implementation HTTPConnection 
@synthesize delegate;

static HTTPConnection* instance;

+(HTTPConnection*)getInstance {
    @synchronized(self) {
        if (instance == NULL)
            instance = [[HTTPConnection alloc] init];
        return instance;
    }
}

#pragma mark - send frame

+(NSString*)removeSpacesFromString:(NSString*)str {
    NSMutableString* result = [[NSMutableString alloc] initWithString:str];
    [result replaceOccurrencesOfString:@" " withString:@"%20" options:NSLiteralSearch range:NSMakeRange(0, [str length])];
    return result;
}

+(NSString*)generateURL {
    NSString* salt = @"a dzwony bily wciaz...";
    NSString* md = [[NSString alloc] initWithFormat:@"%@%d%@", PLAYER_NAME, SCORE, salt];
    
    NSLog(@"str to md: %@", md);
    
    md = [Crypto calculateMD5:md];
    NSString* result = [NSString stringWithFormat:@"%@/~tomek/?name=%@&score=%d&h=%@&n=%d", [Util getServerAddress], [HTTPConnection removeSpacesFromString:PLAYER_NAME], SCORE, md, HIGHSCORE_LIST_LENGTH];
    
    NSLog(@"generated url: %@", result);    
    return result;
}

+(void)sendSimplePostRequest {
    HTTPConnection* conn = [HTTPConnection getInstance];
    
    NSURL* url = [NSURL URLWithString:[HTTPConnection generateURL]];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HTTP_CONNECTION_TIMEOUT];
    [req setHTTPMethod:@"POST"]; 
    
    //NSData* data = [NSData data];
    //[req setHTTPBody:data];
    
    NSURLConnection* connection = [NSURLConnection connectionWithRequest:req delegate:conn];
    [connection start];

}

#pragma mark - manager lifecycle

- (id)init {
    if ((self = [super init])) {
        receivedData = [[NSMutableData data] retain];
    }
    return self;
}

- (void)dealloc {
    [delegate release];
    [receivedData release];
    [super dealloc];
}

#pragma mark - NSConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    
    NSString* strResponse = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];    
    NSLog(@"Received msg: %@", strResponse);
    
    // parse string
    NSMutableArray* result = [NSMutableArray array];;
    
    NSArray* rows = [strResponse componentsSeparatedByString:@";;||;;"];
    for (NSString* row in rows) {
        NSArray* elements = [row componentsSeparatedByString:@";;;"];
        if ([elements count] == 2) {
            NSLog(@"[%@, %@], ", [elements objectAtIndex:0], [elements objectAtIndex:1]);
            
            [result addObject:[elements objectAtIndex:0]];
            [result addObject:[elements objectAtIndex:1]];            
        }
    }    
    [strResponse release];
    
    [self.delegate updateWithHighscores:result];
}

@end
