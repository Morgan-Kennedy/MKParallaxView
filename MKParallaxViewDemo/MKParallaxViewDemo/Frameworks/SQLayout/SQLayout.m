/*
 Copyright (C) 2009-2010 Bradley Clayton. All rights reserved.
 
 SQLayout can be downloaded from:
 https://bitbucket.org/dotb/sqlayout/
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include "SQLayout.h"

@interface SQLayout ()
// Layout a child view within a parent
+ (UIView*) layoutView:(UIView *) view withinParentView:(UIView*) parentView
             alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding;

// Layout a view relative to a peer
+ (UIView*) layoutView:(UIView *) view relativeToPeerView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding;


+ (void)resizeUILabel:(UILabel *) label constrainedToTotalSize:(CGSize) size;
@end

@implementation SQLayout

const SQPadding SQPaddingZero = {
    .top = 0.,
    .bottom = 0.,
    .left = 0.,
    .right = 0.
};

+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
              withSize:(CGSize) size
           withPadding:(SQPadding) padding
{
    return [SQLayout layoutView:view relativeToView:relativeView
                      placement:placement alignment:alignment
                      withWidth:size.width withHeight:size.height
                    withPadding:padding];
}

+ (UIView*) layoutView:(UIView *) view relativeToView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding

{
    CGRect viewFrame = [view frame];
    
    /* If the view is not placed within a superview, attempt to add
     * it to a superview based on it's placement strategy.
     */
    if (![view superview] && (placement & SQPlaceWithin))
    {
        [relativeView addSubview:view];
    }
    else if (![view superview] && [relativeView superview])
    {
        [[relativeView superview] addSubview:view];
    }
    
    viewFrame.size.width = width;
    viewFrame.size.height = height;
    
    // Update the view with the correct size
    [view setFrame:viewFrame];
    
    // Is the view a child of the relative View ?
    if ([view superview] == relativeView)
    {
        [self layoutView:view withinParentView:relativeView alignment:alignment
               withWidth:viewFrame.size.width withHeight:viewFrame.size.height
             withPadding:padding];
    }
    else
    {
        // Assume the view is a peer of the relative view
        [self layoutView:view relativeToPeerView:relativeView
               placement:placement alignment:alignment
               withWidth:viewFrame.size.width withHeight:viewFrame.size.height
             withPadding:padding];
    }
    
    // Round off the coordinate and size to ensure pixel perfect rendering
    viewFrame = [view frame];
    viewFrame.origin.x = (int) viewFrame.origin.x;
    viewFrame.origin.y = (int) viewFrame.origin.y;
    viewFrame.size.width = (int) viewFrame.size.width;
    viewFrame.size.height = (int) viewFrame.size.height;
    [view setFrame:viewFrame];
    
    return view;
}



// Layout a child view within a parent
+ (UIView*) layoutView:(UIView*) view withinParentView:(UIView*) parentView
             alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding
{
    CGRect frame = [view frame];
    
    // Alignment
    if (alignment & SQAlignLeft)
        frame.origin.x = padding.left;
    
    if (alignment & SQAlignRight)
        frame.origin.x = parentView.bounds.size.width - width - padding.right;
    
    if (alignment & SQAlignExactLeft)
        frame.origin.x = 0;
    
    if (alignment & SQAlignExactRight)
        frame.origin.x = parentView.bounds.size.width - width;
    
    if (alignment & SQAlignHCenter)
        frame.origin.x = (parentView.bounds.size.width / 2 - width / 2) + padding.left - padding.right;
    
    if (alignment & SQAlignVCenter)
        frame.origin.y = (parentView.bounds.size.height / 2 - height / 2) + padding.top - padding.bottom;
    
    if (alignment & SQAlignExactHCenter)
        frame.origin.x = (parentView.bounds.size.width / 2 - width / 2);
    
    if (alignment & SQAlignExactVCenter)
        frame.origin.y = (parentView.bounds.size.height / 2 - height / 2);
    
    if (alignment & SQAlignTop)
        frame.origin.y = padding.top;
    
    if (alignment & SQAlignBottom)
        frame.origin.y = parentView.bounds.size.height - height - padding.bottom;
    
    if (alignment & SQAlignExactTop)
        frame.origin.y = 0;
    
    if (alignment & SQAlignExactBottom)
        frame.origin.y = parentView.bounds.size.height - height;
    
    [view setFrame:frame];
    return view;
}

// Layout a view relative to a peer
+ (UIView*) layoutView:(UIView *) view relativeToPeerView:(UIView*) relativeView
             placement:(SQPlace) placement alignment:(SQAlign) alignment
             withWidth:(CGFloat) width withHeight:(CGFloat) height
           withPadding:(SQPadding) padding;
{
    CGRect frame = [view frame];
    
    // Placement
    if (placement & SQPlaceOnLeft)
        frame.origin.x = relativeView.frame.origin.x - width - padding.right;
    
    if (placement & SQPlaceOnRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width + padding.left;
    
    if (placement & SQPlaceAbove)
        frame.origin.y = relativeView.frame.origin.y - height - padding.bottom;
    
    if (placement & SQPlaceBelow)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height + padding.top;
    
    // Alignment
    if (alignment & SQAlignLeft)
        frame.origin.x = relativeView.frame.origin.x + padding.left;
    
    if (alignment & SQAlignRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width - width - padding.right;
    
    if (alignment & SQAlignExactLeft)
        frame.origin.x = relativeView.frame.origin.x;
    
    if (alignment & SQAlignExactRight)
        frame.origin.x = relativeView.frame.origin.x + relativeView.frame.size.width - width;
    
    if (alignment & SQAlignHCenter)
        frame.origin.x = (relativeView.frame.origin.x + relativeView.frame.size.width / 2 - width / 2) + padding.left - padding.right;
    
    if (alignment & SQAlignVCenter)
        frame.origin.y = (relativeView.frame.origin.y + relativeView.frame.size.height / 2 - height / 2) + padding.left - padding.bottom;
    
    if (alignment & SQAlignExactHCenter)
        frame.origin.x = (relativeView.frame.origin.x + relativeView.frame.size.width / 2 - width / 2);
    
    if (alignment & SQAlignExactVCenter)
        frame.origin.y = (relativeView.frame.origin.y + relativeView.frame.size.height / 2 - height / 2);
    
    if (alignment & SQAlignTop)
        frame.origin.y = relativeView.frame.origin.y + padding.top;
    
    if (alignment & SQAlignBottom)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height - height - padding.bottom;
    
    if (alignment & SQAlignExactTop)
        frame.origin.y = relativeView.frame.origin.y;
    
    if (alignment & SQAlignExactBottom)
        frame.origin.y = relativeView.frame.origin.y + relativeView.frame.size.height - height;
    
    [view setFrame:frame];
    return view;
}


+ (void)resizeUILabel:(UILabel *) label constrainedToTotalSize:(CGSize) size
{
    CGRect labelFrame = [label frame];
    CGSize labelTextSize = [[label text] sizeWithFont:[label font] constrainedToSize:size lineBreakMode:[label lineBreakMode]];
    
    [label setFrame:CGRectMake(labelFrame.origin.x, labelFrame.origin.y, labelTextSize.width, labelTextSize.height)];
}

@end