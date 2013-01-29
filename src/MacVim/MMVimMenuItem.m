//
//  VimMenuItem.m
//  menuTest
//
//  Created by Gordon Child on 1/23/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import "MMVimMenuItem.h"
#import "MMVimMenuItemView.h"
#import "MMVimMenu.h"

@implementation MMVimMenuItem
@synthesize tip;

-(id) initWithTitle:(NSString*)title action:(SEL)aSelector keyEquivalent:(NSString *)charCode {
    if(self = [super initWithTitle:title action:aSelector keyEquivalent:charCode]) {
        if(self.isSeparatorItem) {
            [self setView:[[MMVimMenuItemView alloc] initAsSeperator]];
        } else {
            [self setView:[[MMVimMenuItemView alloc] initWithTitle:title keyEquivalent:@"" withModifier:0 tip:@""]];
        }
        [(MMVimMenu*)self.menu widthRequiresUpdate];
    }
    return self;
}

-(CGFloat) getCalculatedWidth {
    return [(MMVimMenuItemView*)self.view MinWidth];
}

-(void) setMaxWidth:(CGFloat)aMaxWidth {
    MMVimMenuItemView* myView = (MMVimMenuItemView*)self.view;
    [myView setMaxWidth:aMaxWidth];
    [myView resizeView];
}

-(void)setTip:(NSString*)aTip {
    MMVimMenuItemView* myView = (MMVimMenuItemView*)self.view;
    myView.Tip.stringValue = aTip;
    [myView resizeView];
}

-(void)setTitle:(NSString*) aTitle {
    [super setTitle:aTitle];
    MMVimMenuItemView* myView = (MMVimMenuItemView*)self.view;
    myView.Title.stringValue = aTitle;
    [myView resizeView];
}

-(void)setAttributedTitle:(NSAttributedString*) aTitle {
    [super setAttributedTitle:aTitle];
}

-(void)setKeyEquivalent:(NSString *)aKeyEquivalent {
    [super setKeyEquivalent:aKeyEquivalent];
    MMVimMenuItemView* myView = (MMVimMenuItemView*)self.view;
    myView.KeyEquivalent.stringValue = aKeyEquivalent;
    [myView resizeView];
}

-(void) setKeyEquivalent:(NSString*)aKeyEquivalent andModifierMask:(NSUInteger) mask {
    [super setKeyEquivalent:aKeyEquivalent];
    [super setKeyEquivalentModifierMask:mask];
    MMVimMenuItemView* myView = (MMVimMenuItemView*)self.view;
    [myView setKeyEquiv:aKeyEquivalent withModifier:mask];
    [myView resizeView];
}

-(void)setKeyEquivalentModifierMask:(NSUInteger)mask {
    [super setKeyEquivalentModifierMask:mask];
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        if(self.isSeparatorItem) {
            [self setView:[[MMVimMenuItemView alloc] initAsSeperator]];
        } else if(self.hasSubmenu) {
            [self setView:[[MMVimMenuItemView alloc] initSubMenuWithTitle:self.title]];
        } else {
            [self setView:[[MMVimMenuItemView alloc] initWithTitle:self.title keyEquivalent:self.keyEquivalent withModifier:self.keyEquivalentModifierMask tip:@""]];
        }
        [(MMVimMenuItemView*)self.view resizeView];
        if([self.menu isKindOfClass:[MMVimMenu class]]) {
            [(MMVimMenu*)self.menu widthRequiresUpdate];
        }
    }
    return self;
}

-(id) initSeperator {
    self = (MMVimMenuItem*)[NSMenuItem separatorItem];
    if(self) {
        [self setView:[[MMVimMenuItemView alloc] initAsSeperator]];
        [(MMVimMenuItemView*)self.view resizeView];
        if([self.menu isKindOfClass:[MMVimMenu class]]) {
            [(MMVimMenu*)self.menu widthRequiresUpdate];
        }
    }
    return self;
}

-(id) init {
    if(self = [super init]) {
        [self setView:[[MMVimMenuItemView alloc] init]];
    }
    return self;
}

@end
