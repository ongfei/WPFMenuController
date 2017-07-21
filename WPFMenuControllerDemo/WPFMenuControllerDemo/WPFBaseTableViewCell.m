//
//  WPFBaseTableViewCell.m
//  WPFMenuControllerDemo
//
//  Created by Leon on 2017/7/21.
//  Copyright © 2017年 Leon. All rights reserved.
//

#import "WPFBaseTableViewCell.h"
#import "Masonry.h"

static NSInteger const kAvatarSize = 45;
static NSInteger const kAvatarMarginH = 10;

@interface WPFBaseTableViewCell ()

/** 头像 */
@property (nonatomic, strong) UIImageView *avatarHeaderView;

@end

@implementation WPFBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString*)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.alignement = [reuseIdentifier containsString:kCellIdentifierLeft] ? MessageAlignementLeft : MessageAlignementRight;
        
        [self buildCell];
//        [self bindGestureRecognizer];
    }
    return self;
}

- (void)buildCell {
    self.contentView.backgroundColor = [UIColor colorWithWhite:241/255.0 alpha:1];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //头像约束
    [self.contentView addSubview:self.avatarHeaderView];
    
    CGFloat margin = 6;
    
    self.bubbleView = [[UIImageView alloc] init];
    self.bubbleView.userInteractionEnabled = true;
    [self.contentView addSubview:self.bubbleView];
    
    self.avatarHeaderView = [[UIImageView alloc] init];
    self.avatarHeaderView.backgroundColor = [UIColor redColor];
    self.avatarHeaderView.layer.cornerRadius = kAvatarSize / 2;
    self.avatarHeaderView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.avatarHeaderView];
    
    if (self.alignement == MessageAlignementLeft) {
        
        UIImage *bubbleImage = [UIImage imageNamed:@"qq_bubble_b"];
        self.bubbleView.image = [bubbleImage stretchableImageWithLeftCapWidth:13 topCapHeight:15];
        [self.avatarHeaderView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(self.contentView);
            make.width.height.mas_equalTo(kAvatarSize);
            make.leading.offset(kAvatarMarginH);
        }];
        
        [self.bubbleView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.width.lessThanOrEqualTo(self.contentView);
            make.top.equalTo(self.contentView);
            //指view的左边在avatar的右边，边距为5
            make.left.equalTo(self.contentView).offset(kAvatarSize + 18);
            //这个地方必须制定contentView，不指定的话没有效果
            make.right.lessThanOrEqualTo(self.contentView).offset(-73);
            //            make.bottom.equalTo(self.thumbUpButton.mas_top);
        }];
        
    } else {
        UIImage *bubbleImage = [UIImage imageNamed:@"qq_bubble_a"];
        self.bubbleView.image = [bubbleImage stretchableImageWithLeftCapWidth:5 topCapHeight:15];
        [self.avatarHeaderView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(self.contentView);
            make.width.height.mas_equalTo(kAvatarSize);
            make.trailing.offset(-kAvatarMarginH);
        }];
        
        [self.bubbleView mas_makeConstraints:^(MASConstraintMaker* make) {
            make.width.lessThanOrEqualTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-kAvatarSize - 18);
            make.left.greaterThanOrEqualTo(self.contentView).offset(73);
            //            make.bottom.equalTo(self.thumbUpButton.mas_top);
        }];
    }
}

- (void)setMessage:(WPFMessage *)message {
    _message = message;
    NSString *imageName = message.msgDirection == WPFMessageDirectionIncoming ? @"liuyifei" : @"xiaohuangren";
    [self.avatarHeaderView setImage:[UIImage imageNamed:imageName]];
    
    
}


@end