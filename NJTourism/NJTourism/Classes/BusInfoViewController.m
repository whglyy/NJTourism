//
//  BusInfoViewController.m
//  NJTourism
//
//  Created by lyywhg on 13-6-22.
//
//

#import "BusInfoViewController.h"

#define FONTSIZE 16
#define CELLHEIGTH ((kFullScreenHeight-44)/5)

@interface BusInfoViewController ()

@end

@implementation BusInfoViewController

static NSInteger numberOfRow = 5;

bool isOpen[5] = {NO, NO, NO, NO, NO};

- (void)dealloc
{
    TT_RELEASE_SAFELY(_questionsArray);
    TT_RELEASE_SAFELY(_answerArray);
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.titleLabel.text = L(@"Questions");
		self.navigationController.navigationBarHidden = NO;
    }
    return self;
}

- (NSMutableArray *)questionsArray
{
    if (!_questionsArray)
    {
        NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"QuestionData" ofType:@"plist"];
        _questionsArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFile];
    }
    return _questionsArray;
}

- (NSArray *)answerArray
{
    if (!_answerArray)
    {
        NSString *plistFile = [[NSBundle mainBundle] pathForResource:@"AnswerData" ofType:@"plist"];
        _answerArray = [[NSMutableArray alloc] initWithContentsOfFile:plistFile];
    }
    return _answerArray;
}

- (void)loadView
{
    [super loadView];
    
    UIImage *bgImage = [UIImage imageNamed:@""];
    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.bodyView.frame = self.view.bounds;
    [self.bodyView setBackgroundColor:RGBACOLOR(220,228,228,1)];
    
    self.tableView.frame = self.bodyView.bounds;
    [self.bodyView addSubview:self.tableView];
    
    self.tableView.top = self.navBarView.bottom + 6;
    self.tableView.height = self.view.height - self.tableView.top - 8;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
    AppDelegate *appdelegate = [AppDelegate currentAppDelegate];
    [[appdelegate.tabBarViewController customTabBar] setHidden:YES];
}

#pragma mark Set Table
- (int)openNumber
{
    for (int i = 0; i < 5; i++)
    {
        if (isOpen[i] == YES)
        {
            return i;
        }
    }
    return 5;
}

- (CGSize)sendHeight:(NSIndexPath*)indexPath array:(NSArray *)array width:(float)width
{
    NSString *tmpString = [[NSString alloc] initWithString:[array objectAtIndex:[indexPath section]]];
    
    CGSize labelSize = [tmpString heightWithFont:[UIFont boldSystemFontOfSize:FONTSIZE]  width:width linebreak:UILineBreakModeCharacterWrap];
    TT_RELEASE_SAFELY(tmpString);
    return labelSize;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return numberOfRow;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (isOpen[section] == YES ? 2:1);
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AnswerCellIdentifier = @"AnswerCellIdentifier";
    static NSString *QuestionCellIdentifier = @"QuestionCellIdentifier";
    CGSize labelSize;
    if ([indexPath row] == 0)
    {
        DropDownCell *customCell = [tableView dequeueReusableCellWithIdentifier:QuestionCellIdentifier];
        customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (customCell == nil)
        {
            customCell = [[[DropDownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:QuestionCellIdentifier] autorelease];
            customCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        customCell.topTextLabel.text = [self.questionsArray objectAtIndex:[indexPath section]];
        
        labelSize = [self sendHeight:indexPath array:self.questionsArray width:260];
        
        customCell.topTextLabel.numberOfLines = labelSize.height / FONTSIZE + 1;
        customCell.topTextLabel.frame = CGRectMake(19, 10, 260, CELLHEIGTH - 10);
        customCell.backgroundImage.height = CELLHEIGTH - 10;
        
        customCell.arrow_down.hidden = !isOpen[[indexPath section]];
        customCell.arrow_up.hidden = isOpen[[indexPath section]];
        
        return customCell;
    }
    
    {
        AnswerCell *answerCell = [tableView dequeueReusableCellWithIdentifier:AnswerCellIdentifier];
        answerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (answerCell == nil)
        {
            answerCell = [[[AnswerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerCellIdentifier] autorelease];
            answerCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        answerCell.answerTextLabel.text = [self.answerArray objectAtIndex:[indexPath section]];
        
        switch (indexPath.section)
        {
            case 0:
            {
                [answerCell setAnswerLabel:CGRectMake(27.5, 5, 272, 136) answerLabel:6 backgroundImage:CGRectMake(10, -15, 300, 166)];
                break;
            }
            case 1:
            {
                [answerCell setAnswerLabel:CGRectMake(27.5, 5, 272, 168) answerLabel:7 backgroundImage:CGRectMake(10, -15, 300, 190)];
                break;
            }
            case 2:
            {
                [answerCell setAnswerLabel:CGRectMake(27.5, 5, 272, 192) answerLabel:8 backgroundImage:CGRectMake(10, -15, 300, 214)];
                break;
            }
            case 3:
            {
                [answerCell setAnswerLabel:CGRectMake(27.5, 5, 272, 120) answerLabel:5 backgroundImage:CGRectMake(10, -15, 300, 142)];
                break;//120-96 = 一行 142 - 118
            }
            case 4:
            {
                [answerCell setAnswerLabel:CGRectMake(27.5, 5, 272, 120) answerLabel:5 backgroundImage:CGRectMake(10, -15, 300, 142)];
                break;
            }
            default:
                break;
        }
        return answerCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 1)
    {
        return;
    }
    
#if 0
    int sectionInt = [self openNumber];
    DLog(@"msg_lyy: tmpInt = %d", sectionInt);
    if (sectionInt != 5 && sectionInt != [indexPath section])
    {
        DropDownCell *openCell = (DropDownCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSIndexPath *openCellPath = [NSIndexPath indexPathForRow:1 inSection:sectionInt];
        NSArray *openIndexPathArray = [NSArray arrayWithObjects:openCellPath, nil];
        [openCell setClosed];
        isOpen[sectionInt] = [openCell isOpen];
        [tableView deleteRowsAtIndexPaths:openIndexPathArray withRowAnimation:UITableViewRowAnimationTop];
    }
#endif
    
    DropDownCell *cell = (DropDownCell *)[tableView cellForRowAtIndexPath:indexPath];
    NSIndexPath *cellPath = [NSIndexPath indexPathForRow:1 inSection:[indexPath section]];
    
    NSArray *indexPathArray = [NSArray arrayWithObjects:cellPath, nil];
    if (isOpen[[indexPath section]] == YES)
    {
        isOpen[[indexPath section]] = [cell setClosed];;
        [tableView deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        cell.arrow_down.hidden = !isOpen[[indexPath section]];
        cell.arrow_up.hidden = isOpen[[indexPath section]];
    }
    else
    {
        isOpen[[indexPath section]] = [cell setOpen];
        [tableView insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationFade];
        [tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionMiddle];
        cell.arrow_down.hidden = !isOpen[[indexPath section]];
        cell.arrow_up.hidden = isOpen[[indexPath section]];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0)
    {
        return CELLHEIGTH;
    }
    else
    {
        switch (indexPath.section)
        {
            case 0:
            {
                return 146;
            }
            case 1:
            {
                return 178;
            }
            case 2:
            {
                return 202;
            }
            case 3:
            {
                return 130;//130-106 = 一行
            }
            case 4:
            {
                return 130;
            }
            default:
                return 0;
                break;
        }
        return 0;
    }
}

@end
