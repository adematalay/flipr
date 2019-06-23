//
//  FLPhotoListFlowLayout.m
//  Flipr
//
//  Created by Adem Atalay on 22.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

#import "FLPhotoListFlowLayout.h"

static CGFloat const FLPhotoListColumns = 3.0;
static CGFloat const FLPhotoListSpace = 2.0;

@implementation FLPhotoListFlowLayout

- (CGSize)itemSize {
    CGFloat w = self.collectionView.contentSize.width / FLPhotoListColumns - (FLPhotoListColumns - 1)*FLPhotoListSpace;
    return CGSizeMake(w, w);
}

- (CGFloat)minimumInteritemSpacing {
    return FLPhotoListSpace;
}

- (CGFloat)minimumLineSpacing {
    return 2*FLPhotoListSpace;
}

@end
