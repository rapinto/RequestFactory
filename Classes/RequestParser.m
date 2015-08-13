//
//  RequestParser.m
//
//
//  Created by Raphaël Pinto on 23/06/2014.
//
// The MIT License (MIT)
// Copyright (c) 2015 Raphael Pinto.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.



#import "RequestParser.h"
#import "AFHTTPRequestOperation.h"
#import "RequestParserDelegate.h"



@implementation RequestParser



@synthesize mDelegate;
@synthesize mRequestKey;



#pragma mark -
#pragma mark Object Life Cycle Methods



- (id)initWithDelegate:(NSObject<RequestParserDelegate> *)delegate
{
    self = [super init];
    
    if (self)
    {
        self.mDelegate = delegate;
    }
    
    return self;
}


- (void)dealloc
{
}



#pragma mark -
#pragma mark Data Management Methods



- (void (^)(AFHTTPRequestOperation *_Operation, NSError* _Error))failureBLock
{
    return ^(AFHTTPRequestOperation *_Operation, NSError* _Error)
    {
        [self handleAFNetworkingError:_Error forOperation:(AFHTTPRequestOperation*)_Operation];
    };
}



#pragma mark -
#pragma mark Error Handling Methods



- (void)handleAFNetworkingError:(NSError*)error forOperation:(AFHTTPRequestOperation*)operation
{
	long statusCode = operation.response.statusCode;
	
	if (statusCode == 0)
	{
		statusCode = error.code;
	}
	
	// Error already handled by the delegate, do not check status code
	if ([mDelegate respondsToSelector:@selector(isOverridedParsingError:forOperation:)])
	{
		if ([mDelegate isOverridedParsingError:error forOperation:operation])
		{
			return;
		}
	}
	
	switch (statusCode)
	{
            // Timeout fire by server
		case NSURLErrorTimedOut:
		case NSURLErrorNotConnectedToInternet:
		case NSURLErrorNetworkConnectionLost:
        case NSURLErrorCannotFindHost:
		{
			[self handleNoConnectionError:error forOperation:operation];
            break;
		}
		case NSURLErrorCancelled:
        {
            [self handleRequestCancelledError:error forOperation:operation];
			break;
        }
		
		default:
		{
            [self handleError:error forOperation:operation];
			break;
		}
	}
}


- (void)handleNoConnectionError:(NSError*)error forOperation:(AFHTTPRequestOperation*)operation
{
    [self.mDelegate requestDidFailWithError:error forOperation:operation];
}


- (void)handleRequestCancelledError:(NSError*)error forOperation:(AFHTTPRequestOperation*)operation
{
    [self.mDelegate requestDidFailWithError:error forOperation:operation];
}


- (void)handleError:(NSError*)error forOperation:(AFHTTPRequestOperation*)operation
{
    [self.mDelegate requestDidFailWithError:error forOperation:operation];
}


@end
