//
//  MMVimMenuItemView.m
//  menuTest
//
//  Created by Gordon Child on 1/23/13.
//  Copyright (c) 2013 Gordon Child. All rights reserved.
//

#import "MMVimMenuItemView.h"

@implementation MMVimMenuItemView
@synthesize Tip;
@synthesize Title;
@synthesize KeyEquivalent;
@synthesize MinWidth;
@synthesize MaxWidth;
@synthesize SubMenuIndicatorLocation;

-(id)init {
    self = [super init];
    if(self) {
        self.Title = [[NSTextField alloc] init];
        self.Title.font = [NSFont fontWithName:@"Lucida Sans Regular" size:14.5];
        self.KeyEquivalent = [[NSTextField alloc] init];
        self.KeyEquivalent.font = [NSFont fontWithName:@"Lucida Sans Regular" size:13.5];
        //[self setKeyEquiv:aKeyEquiv withModifier:aMod];
        self.Tip = [[NSTextField alloc] init];
        self.Tip.font = [NSFont fontWithName:@"Lucida Sans Regular" size:13.5];
        self.frame = NSMakeRect(0, 0, 20, 19);
    }
    return self;
}

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTrackingRect:self.frame owner:self userData:NULL assumeInside:NO];
    }
    return self;
}

-(id)initWithTitle:(NSString*) aTitle
                keyEquivalent:(NSString*) aKeyEquiv
                withModifier:(NSUInteger) aMod
                tip:(NSString*) aTip {
    self = [super init];
    if(self) {
        self.Title = [[NSTextField alloc] init];
        self.Title.font = [NSFont fontWithName:@"Lucida Sans Regular" size:14.5];
        self.Title.stringValue = aTitle;
        self.KeyEquivalent = [[NSTextField alloc] init];
        self.KeyEquivalent.font = [NSFont fontWithName:@"Lucida Sans Regular" size:13.5];
        [self setKeyEquiv:aKeyEquiv withModifier:aMod];
        self.Tip = [[NSTextField alloc] init];
        self.Tip.stringValue = aTip;
        self.frame = NSMakeRect(0, 0, 20, 19);
    }
    return self;
}

-(id)initSubMenuWithTitle:(NSString*)aTitle {
    self = [super init];
    if(self) {
        self.Title = [[NSTextField alloc] init];
        self.Title.font = [NSFont fontWithName:@"Lucida Sans Regular" size:14.5];
        self.Title.stringValue = aTitle;
        self.frame = NSMakeRect(0,0,20,19);
    }
    return self;
}

-(id)initAsSeperator {
    self = [super init];
    if(self) {
        self.frame = NSMakeRect(0, 0, 20, 12);
    }
    return self;
}

-(BOOL)acceptsFirstResponder {
    NSMenuItem* item = [self enclosingMenuItem];
    if(!item.isEnabled
       || item.hasSubmenu) {
        return NO;
    }
    return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

-(void)mouseUp:(NSEvent *)theEvent {
    NSMenuItem* item = [self enclosingMenuItem];
    if(!item.isEnabled
       || item.hasSubmenu) {
        return;
    }
    [item.menu cancelTracking];
    [item setEnabled:NO];
    [item.menu update];
    [item setEnabled:YES];
    [item.menu update];
    //[self setNeedsDisplay:YES];
    [item.menu performActionForItemAtIndex:[item.menu indexOfItem:item]];
}

-(void)viewDidMoveToWindow {
//    [[self enclosingMenuItem].menu cancelTracking];
}

-(void)setKeyEquiv:(NSString*)keyEquiv withModifier:(NSUInteger)mod {
    NSString* kEquiv = @"";
    self.KeyEquivalent = [[NSTextField alloc] init];
    self.KeyEquivalent.font = [NSFont fontWithName:@"Lucida Sans Regular" size:13.5];
    if(keyEquiv.length > 0) {
        if(mod & NSControlKeyMask)
            kEquiv = [kEquiv stringByAppendingString:@"\u2303"];
        if(mod & NSAlternateKeyMask)
            kEquiv = [kEquiv stringByAppendingString:@"\u2325"];
        if(mod & NSShiftKeyMask || [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:[keyEquiv characterAtIndex:0]])
            kEquiv = [kEquiv stringByAppendingString:@"\u21e7"];
        if(mod & NSCommandKeyMask)
            kEquiv = [kEquiv stringByAppendingString:@"\u2318"];
        kEquiv = [kEquiv stringByAppendingString:[keyEquiv uppercaseString]];
        self.KeyEquivalent.stringValue = kEquiv;
    } else {
        self.KeyEquivalent.stringValue = @"";
    }
    [self resizeView];
}

- (void)drawRect:(NSRect)rect {
    if([self enclosingMenuItem].isSeparatorItem) {
        NSColor* seperatorColor = [NSColor colorWithCalibratedRed:0.8862 green:0.8862 blue:0.8862 alpha:1];
        NSRect seperatorRect = NSMakeRect(1, 5, rect.size.width - 2, 1);
        NSBezierPath* seperator = [NSBezierPath bezierPathWithRect:seperatorRect];
        [seperatorColor setFill];
        [seperator fill];
        return;
    }
    if([self enclosingMenuItem].isHighlighted) {
        NSColor* topGradColor = [NSColor colorWithCalibratedRed:0.1764 green:0.2784 blue:0.9765 alpha:1];
        NSColor* bottomGradColor = [NSColor colorWithCalibratedRed:0.3921 green:0.4901 blue:0.9843 alpha:1];
        NSGradient* aGradient =
            [[NSGradient alloc]
             initWithStartingColor:topGradColor
             endingColor:bottomGradColor];
        [aGradient drawInRect:[self bounds] angle:90];
        
        NSColor* topLineColor = [NSColor colorWithCalibratedRed:0.3529 green:0.4549 blue:0.9451 alpha:1];
        NSColor* bottomLineColor = [NSColor colorWithCalibratedRed:0.1412 green:0.2078 blue:0.9373 alpha:1];
        NSRect topLineRect = NSMakeRect(0, rect.size.height - 1, rect.size.width, 1);
        NSRect bottomLineRect = NSMakeRect(0, 0, rect.size.width, 1);
        
        NSBezierPath* topLine = [NSBezierPath bezierPathWithRect: topLineRect];
        [topLineColor setFill];
        [topLine fill];
        
        NSBezierPath* bottomLine = [NSBezierPath bezierPathWithRect:bottomLineRect];
        [bottomLineColor setFill];
        [bottomLine fill];
    }
    if([self enclosingMenuItem].hasSubmenu) {
        [self drawSubMenuIndicator:rect];
    }
    [self drawText:rect];
}

-(void)drawSubMenuIndicator:(NSRect)rect {
    NSColor* color = [NSColor colorWithCalibratedRed:0.25 green:0.25 blue:0.25 alpha:1];
    if([self enclosingMenuItem].isHighlighted) {
        color = [NSColor whiteColor];
    }
    if(![self enclosingMenuItem].isEnabled) {
        color = [NSColor colorWithCalibratedRed:0.65 green:0.65 blue:0.65 alpha:1];
    }
    CGFloat x = rect.size.width - 20;
    CGFloat y = 5;
    NSBezierPath* polygonPath = [NSBezierPath bezierPath];
    [polygonPath moveToPoint: NSMakePoint(x+0,y+10)];
    [polygonPath lineToPoint: NSMakePoint(x+9,y+5)];
    [polygonPath lineToPoint: NSMakePoint(x+0,y+0)];
    [polygonPath closePath];
    [color setFill];
    [polygonPath fill];
}

-(void)drawText:(NSRect)frame {
    NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    [textStyle setAlignment: NSLeftTextAlignment];
    NSColor* color = [NSColor textColor];
    if([self enclosingMenuItem].isHighlighted) {
        color = [NSColor whiteColor];
    }
    if(![self enclosingMenuItem].isEnabled) {
        color = [NSColor colorWithCalibratedRed:0.57 green:0.57 blue:0.57 alpha:1];
    }
    NSDictionary* textFontAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
            self.Title.font, NSFontAttributeName,
            color, NSForegroundColorAttributeName,
            textStyle, NSParagraphStyleAttributeName, nil];
    
    [self.Title.stringValue drawInRect: self.Title.frame withAttributes: textFontAttributes];
    [self.KeyEquivalent.stringValue drawInRect:self.KeyEquivalent.frame withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.KeyEquivalent.font, NSFontAttributeName,
        color, NSForegroundColorAttributeName,
        textStyle, NSParagraphStyleAttributeName, nil]];
    [self.Tip.stringValue drawInRect:self.Tip.frame withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
            self.Tip.font, NSFontAttributeName,
            color, NSForegroundColorAttributeName,
            textStyle, NSParagraphStyleAttributeName, nil]];
}

-(void)resizeView {
    CGFloat titleLeftPadding = 21;
    CGFloat hotkeyRightPadding = 11;
    CGFloat subMenuRightPadding = 20;
    CGFloat hotkeyMinLeftPadding = 35;
    CGFloat subMenuMinLeftPadding = 35;
    CGFloat tipRightPadding = 20;
    //float subMenuIndicatorRightPadding = 10;
    CGFloat totalWidth = 0;
    NSRect newTitleFrame;
    CGSize keyEquivSize;
    CGSize tipSize;
    if(self.Title.stringValue.length > 0) {
        CGSize titleSize = [self sizeOfString:self.Title.stringValue withFont:self.Title.font];
        totalWidth += titleLeftPadding;
        totalWidth += titleSize.width;
        newTitleFrame = NSMakeRect(titleLeftPadding, 1.5, titleSize.width, titleSize.height);
    }
    if([self enclosingMenuItem].hasSubmenu) {
        totalWidth += subMenuMinLeftPadding;
        totalWidth += 9; //submenu width
        totalWidth += subMenuRightPadding;
    }
    if(self.Tip.stringValue.length > 0) {
        tipSize = [self sizeOfString:self.Tip.stringValue withFont:self.Tip.font];
        totalWidth += hotkeyMinLeftPadding;
        totalWidth += tipSize.width;
        totalWidth += hotkeyRightPadding;
        totalWidth += tipRightPadding;
    }
    if(self.KeyEquivalent.stringValue.length > 0) {
        keyEquivSize = [self sizeOfString:self.KeyEquivalent.stringValue withFont:self.KeyEquivalent.font];
        totalWidth += hotkeyMinLeftPadding;
        totalWidth += hotkeyRightPadding;
        totalWidth += keyEquivSize.width;
    }
    self.MinWidth = totalWidth;
    CGFloat widthToUse = self.MaxWidth;
    if(totalWidth > self.MaxWidth) {
        widthToUse = totalWidth;
    }
    self.frame = NSMakeRect(0, 0, widthToUse, self.frame.size.height);
    if(self.KeyEquivalent.stringValue.length > 0) {
        float x = widthToUse - hotkeyRightPadding - keyEquivSize.width;
        self.KeyEquivalent.frame = NSMakeRect(x, 1, keyEquivSize.width, keyEquivSize.height);
    }
    if(self.Tip.stringValue.length > 0) {
        float x = widthToUse - hotkeyRightPadding - keyEquivSize.width - tipSize.width - tipRightPadding;
        self.Tip.frame = NSMakeRect(x, 1, tipSize.width, tipSize.height);
    }
    if(self.Title.stringValue.length > 0)
      self.Title.frame = newTitleFrame;
    //[self addTrackingRect:self.frame owner:self userData:NULL assumeInside:NO];
}

- (CGSize)sizeOfString:(NSString *)string withFont:(NSFont *)font {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    return [[[NSAttributedString alloc] initWithString:string attributes:attributes] size];
}

@end
