//
//  MMVimMenu.m
//  menuTest
//
//  Created by Gordon Child on 1/27/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import "MMVimMenu.h"
#import "MMVimMenuItem.h"

@implementation MMVimMenu
@synthesize maxWidth;

-(void) widthRequiresUpdate {
    self.maxWidth = [self getNewMaxWidth];
    [self updateMaxWidthOnAllItems];
}

-(CGFloat) getNewMaxWidth {
    CGFloat newMaxWidth = 0;
    for(NSMenuItem* item in self.itemArray) {
        if([item isKindOfClass:[MMVimMenuItem class]]) {
            CGFloat calcWidth = [(MMVimMenuItem*)item getCalculatedWidth];
            if(calcWidth > newMaxWidth) {
                newMaxWidth = calcWidth;
            }
        }
    }
    return newMaxWidth;
}

-(void) updateMaxWidthOnAllItems {
    for(NSMenuItem* item in self.itemArray) {
        if([item isKindOfClass:[MMVimMenuItem class]]) {
            [(MMVimMenuItem*)item setMaxWidth:self.maxWidth];
        }
    }
}

-(void) itemChanged:(NSMenuItem *)item {
    [self widthRequiresUpdate];
}

@end
