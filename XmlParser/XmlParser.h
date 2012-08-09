//
//  XmlParser.h
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlParser : NSObject<NSXMLParserDelegate>
{
    NSMutableString *currentElementValue;
    NSString *currentElement;
}

@end
