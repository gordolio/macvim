//
//  MMVimMenuItemView.h
//  menuTest
//
//  Created by Gordon Child on 1/23/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MMVimMenuItem.h"

@interface MMVimMenuItemView : NSView {
    NSTextField* Tip;
    NSTextField* Title;
    NSTextField* KeyEquivalent;
    CGFloat MinWidth; // MinWidth indicates the minimum width
                      // that this view can draw within
                      // This should be refreshed anytime something
                      // Is changed
    
    CGFloat MaxWidth; // MaxWidth indicates what the parent
                      // menu wants the view to draw within
                      // This should be refreshed any time another
                      // menu item is changed within the parent menu
                      // This is used for drawing
    CGFloat SubMenuIndicatorLocation;
}
@property (nonatomic,retain) NSTextField* Tip;
@property (nonatomic,retain) NSTextField* Title;
@property (nonatomic,retain) NSTextField* KeyEquivalent;
@property (assign) CGFloat MinWidth;
@property (assign) CGFloat MaxWidth;
@property (assign) CGFloat SubMenuIndicatorLocation;

-(id)initWithTitle:(NSString*) aTitle
     keyEquivalent:(NSString*) aKeyEquiv
      withModifier:(NSUInteger) aMod
               tip:(NSString*) aTip;
-(id)initAsSeperator;
-(id)initSubMenuWithTitle:(NSString*)aTitle;
-(void)setKeyEquiv:(NSString*)keyEquiv withModifier:(NSUInteger)mod;

-(void)resizeView;

@end
