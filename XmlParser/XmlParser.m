//
//  XmlParser.m
//  ICDataflow
//
//  Created by Apple on 31/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "XmlParser.h"

@implementation XmlParser

#pragma mark NSXMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
    currentElement = [elementName copy];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{
}  

- (void)parser:(NSXMLParser *)parser  didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName 
{
    currentElementValue = nil;
}


@end
