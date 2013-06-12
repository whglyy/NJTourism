//
//  SearchCondtion.h
//  SuningIM
//
//  Created by shasha on 13-6-3.
//
//


@interface SearchCondtion : NSObject
@property (nonatomic, strong) NSString  *searchKeyWord;
@property (nonatomic, strong) NSString  *searchType;
@property (nonatomic, strong) NSString  *nickName;
@property (nonatomic, strong) NSString  *region;
@property (nonatomic, strong) NSString  *locality;
@property (nonatomic, strong) NSString  *sex;
@property (nonatomic, strong) NSString  *ageFrom;
@property (nonatomic, strong) NSString  *ageTo;

@property (nonatomic, strong) NSString  *index;
@property (nonatomic, strong) NSString  *max;

@end
