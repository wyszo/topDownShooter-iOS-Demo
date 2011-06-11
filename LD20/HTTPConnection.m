//
//  HTTPConnectionDelegate.m
//  LD20
//
//  Created by tomek on 6/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HTTPConnection.h"

@implementation HTTPConnection 
static HTTPConnection* instance;

+(HTTPConnection*)getInstance {
    @synchronized(self) {
        if (instance == NULL)
            instance = [[HTTPConnection alloc] init];
        return instance;
    }
}

#pragma mark - send frame

static NSString* SERVER_ADDRESS = @"http://127.0.0.1:8080";
static const NSTimeInterval HTTP_CONNECTION_TIMEOUT = 60.0;


+(void)sendDummyHttpFrame {
    HTTPConnection* conn = [HTTPConnection getInstance];
    
    NSURL* url = [NSURL URLWithString:SERVER_ADDRESS];
    
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:HTTP_CONNECTION_TIMEOUT];
    [req setHTTPMethod:@"POST"]; 
    
    NSData* data = [NSData data];
    [req setHTTPBody:data];
    
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
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
    
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
    
    // release the connection, and the data object
    [connection release];
    [receivedData release];
}

@end
