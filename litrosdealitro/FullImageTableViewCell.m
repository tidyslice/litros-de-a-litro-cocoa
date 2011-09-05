//
//  FullImageTableViewCell.m
//  litrosdealitro
//
//  Created by Erick Camacho Chavarría on 04/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FullImageTableViewCell.h"

@implementation FullImageTableViewCell

@synthesize backgroundImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
