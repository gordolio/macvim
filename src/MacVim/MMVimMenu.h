//
//  MMVimMenu.h
//  menuTest
//
//  Created by Gordon Child on 1/27/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MMVimMenu : NSMenu {
    CGFloat maxWidth;
}
@property (assign) CGFloat maxWidth;

-(void)widthRequiresUpdate;

-(void)itemChanged:(NSMenuItem *)item;

@end
