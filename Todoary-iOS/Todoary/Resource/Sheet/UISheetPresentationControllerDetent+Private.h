//
//  UISheetPresentationControllerDetent+Private.h
//  Todoary
//
//  Created by 박지윤 on 2022/07/18.
//

#ifndef UISheetPresentationControllerDetent_Private_h
#define UISheetPresentationControllerDetent_Private_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISheetPresentationControllerDetent (Private)
+ (UISheetPresentationControllerDetent *)_detentWithIdentifier:(NSString *)identifier constant:(CGFloat)constant;
@end

NS_ASSUME_NONNULL_END


#endif /* UISheetPresentationControllerDetent_Private_h */
