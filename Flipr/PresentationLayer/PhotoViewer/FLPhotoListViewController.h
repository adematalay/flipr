//
//  FLPhotoListViewController.h
//  Flipr
//
//  Created by Adem Atalay on 21.06.2019.
//  Copyright © 2019 AAtalay. All rights reserved.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN
@class FLPhotoListDataSource;
@interface FLPhotoListViewController : UIViewController

- (instancetype)initWithDataSource:(FLPhotoListDataSource *)dataSource;

@end

NS_ASSUME_NONNULL_END
