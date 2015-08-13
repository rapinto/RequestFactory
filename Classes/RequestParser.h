//
//  RequestParser.h
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



#import <Foundation/Foundation.h>



@class AFHTTPRequestOperation;
@protocol RequestParserDelegate;


typedef void (^request_error_block)(AFHTTPRequestOperation *operation, NSError *error);
typedef void (^request_succes_block)(AFHTTPRequestOperation *operation, id JSON);



@interface RequestParser : NSObject



@property (nonatomic, retain) NSObject<RequestParserDelegate>* mDelegate;
@property (nonatomic, retain) NSString* mRequestKey;



- (id)initWithDelegate:(NSObject<RequestParserDelegate>*)_Delegate;

- (void)handleAFNetworkingError:(NSError*)_Error forOperation:(AFHTTPRequestOperation*)_Operation;

- (void (^)(AFHTTPRequestOperation *_Operation, NSError* _Error))failureBLock;


@end