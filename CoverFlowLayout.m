//
//  CoverFlowLayout.m
//  CoverFlowLayout
//
//  Created by Jenny Nguyen on 2016-11-18.
//  Copyright © 2016 LightHouseLabs. All rights reserved.
//

#import "CoverFlowLayout.h"

#define ITEM_SIZE 200.0

@implementation CoverFlowLayout

#define ACTIVE_DISTANCE 200
#define ZOOM_FACTOR 0.3


-(id)init {
    
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE, ITEM_SIZE);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(200, 0.0, 200, 0.0);
        self.minimumLineSpacing = 50.0;
    }
    return self;
}

//Bounds Change

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

// Content Size

- (CGSize)collectionViewContentSize {
    
    CGFloat deviceHeightLandscape = [UIScreen mainScreen].bounds.size.height;
    
    return CGSizeMake(1500.0, deviceHeightLandscape);
    
}

//Scaling

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        if(CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            
            if (ABS(distance) < ACTIVE_DISTANCE) {
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = round(zoom);
            }
        }
    }
    return array;
    
}



@end
