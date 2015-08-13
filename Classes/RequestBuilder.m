//
//  RequestBuilder.m
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



#import "RequestBuilder.h"



@implementation RequestBuilder



#pragma mark -
#pragma mark Data Management Methods



+ (NSString*)requestKeyForRequest:(NSURLRequest*)_Request
{
    return [NSString stringWithFormat:@"%@-%@", _Request.HTTPMethod, _Request.URL];
}


+ (void)setMultiPartBlockForImageWithDatasArray:(NSMutableArray*)_FileDatas
                                      keysArray:(NSMutableArray*)_FileKeys
                                     namesArray:(NSMutableArray*)_FileNames
                                     mimesArray:(NSMutableArray*)_FileMimes
                                          image:(UIImage*)_Image
                                       imageKey:(NSString*)_ImageKey
                                      imageName:(NSString*)_ImageName
{
    if (_Image.size.height * _Image.size.width > 0 && [_ImageKey length] > 0 && [_ImageName length] > 0)
    {
        [_FileMimes addObject:@"image/jpeg"];
        [_FileNames addObject:[NSString stringWithFormat:@"%@.jpeg", _ImageName]];
        
        NSData* lImageDatas = UIImageJPEGRepresentation(_Image, 0.7f);
        
        [_FileDatas addObject:lImageDatas];
        [_FileKeys addObject:_ImageKey];
    }
}


@end
