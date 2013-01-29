//
//  VimMenuItem.h
//  menuTest
//
//  Created by Gordon Child on 1/23/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MMVimMenuItem : NSMenuItem {
    NSString* tip;
}
@property (nonatomic,retain) NSString* tip;

-(id) initSeperator;
-(void)setMaxWidth:(CGFloat) aMaxWidth;
-(CGFloat) getCalculatedWidth;
-(void)setTip:(NSString*) aTip;
-(void) setKeyEquivalent:(NSString*)aKeyEquivalent andModifierMask:(NSUInteger) mask;

@end
