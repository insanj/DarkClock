#import "DarkClock.h"

%hook UIView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
	UIView *o = %orig();
	if(o)
		NSLog(@"[DarkClock] DEBUG, hit: %@, super:%@, sub:%@", o, o.superview, o.subviews);

	return o;
}

%end

/****************************** Global Changes ******************************/

%ctor{
    [UITabBar appearance].barStyle = UIBarStyleBlack;
    [UINavigationBar appearance].barStyle = UIBarStyleBlack;
    ((UILayoutContainerView *)[%c(UILayoutContainerView) appearance]).backgroundColor = [UIColor blackColor];
    ((UITableViewWrapperView *)[%c(UITableViewWrapperView) appearance]).backgroundColor = [UIColor blackColor];
    [UITableView appearance].backgroundColor = [UIColor blackColor];
   // [UITableViewCell appearance].backgroundColor = [UIColor blackColor];
}

/*
%hook UITableViewWrapperView

-(void)layoutSubviews{
	%orig();

	for(UIView *v in self.subviews)
		if([v isKindOfClass:[UILabel class]])
			((UILabel *)v).textColor = [UIColor whiteColor];
}

%end
*/

%hook UIKBRenderConfig

-(BOOL)lightKeyboard{
	return NO;
}

%end


/****************************** Alarm View Changes ******************************/

%hook TableViewController

-(void)viewWillAppear:(BOOL)arg1{
	%orig();
	MSHookIvar<UITableView *>(self, "_tableView").backgroundColor = [UIColor blackColor];
}

%end

%hook AlarmTableViewCell

-(void)internalSetBackgroundColor:(UIColor *)arg1{
	%orig([UIColor blackColor]);

	if([arg1 isEqual:[UIColor whiteColor]]){
		AlarmView *alarmView = [self.contentView.subviews firstObject];
		for(UIView *v in alarmView.subviews)
			if([v isKindOfClass:[UILabel class]])
				((UILabel *)v).textColor = [UIColor whiteColor];
	}
}

-(void)layoutSubviews{
	%orig();

	AlarmView *alarmView = [self.contentView.subviews firstObject];
	for(UIView *v in alarmView.subviews)
		if([v isKindOfClass:[UISwitch class]])
			((UISwitch *)v).onTintColor = [UIColor redColor];
}

%end

/****************************** World Clock View Changes ******************************/

%hook WorldClockTableViewCell

-(void)layoutSubviews{
	%orig();
	self.backgroundColor = [UIColor blackColor];
}

%end

%hook WorldClockCellView

-(void)layoutSubviews{
	%orig();

	for(UIView *v in self.subviews){
		if([v isKindOfClass:[UILabel class]])
			((UILabel *)v).textColor = [UIColor whiteColor];
		//if([v isKindOfClass:[AnalogClockView class]])
	}
}

%end

%hook AddClockViewController

-(id)init{
	AddClockViewController *view = (AddClockViewController *) %orig();
	view.tableView.backgroundColor = [UIColor blackColor];

	for(UIView *v in view.tableView.subviews){
		if([v isKindOfClass:[%c(UITableViewIndex) class]]){
			((UITableViewIndex *)v).indexBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
			((UITableViewIndex *)v).indexTrackingBackgroundColor = [UIColor colorWithWhite:0.0 alpha:0.25];
		}
	}

	return view;
}

-(id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2{
	UITableViewCell *cell = (UITableViewCell *) %orig();
	cell.backgroundColor = [UIColor blackColor];
	cell.textLabel.textColor = [UIColor whiteColor];
	return cell;
}

%end

/****************************** Stopwatch View Changes ******************************/

%hook StopWatchViewController

-(id)init{
	StopWatchViewController *controller = (StopWatchViewController *) %orig();
	controller.view.backgroundColor = [UIColor blackColor];
	MSHookIvar<UITableView *>(controller, "_lapTimeTable").backgroundColor = [UIColor blackColor];
	return controller;
}

-(id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2{
	UITableViewCell *cell = (UITableViewCell *) %orig();
	cell.backgroundColor = [UIColor blackColor];
	cell.textLabel.textColor = [UIColor whiteColor];
	return cell;
}

%end

%hook MTStopwatchControlsView

-(id)initWithTarget:(id)arg1{
	MTStopwatchControlsView *view = (MTStopwatchControlsView *) %orig();
	MSHookIvar<UIView *>(view, "_buttonsBackgroundView").backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
	return view;
}

%end

%hook StopwatchTimeView

-(id)init{
	StopwatchTimeView *view = (StopwatchTimeView *) %orig();
	view.backgroundColor = [UIColor blackColor];
	return view;
}

-(void)layoutSubviews{
	%orig();

	for(UIView *v in self.subviews){
		if([v isKindOfClass:[UILabel class]]){
			((UILabel *)v).backgroundColor = [UIColor blackColor];
			((UILabel *)v).textColor = [UIColor whiteColor];
		}
	}
}

%end

/****************************** Timer View Changes ******************************/

%hook MTCircleButton

-(void)willMoveToSuperview:(UIView *)newSuperview{
	%orig();
	newSuperview.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1.0];
}

%end

%hook TKToneTableController

-(id)tableView:(id)tableView viewForHeaderInSection:(id)section{
	UIView *orig = %orig();
	orig.backgroundColor = [UIColor blackColor];
	return orig;
}

-(id)tableView:(id)arg1 cellForRowAtIndexPath:(id)arg2{
	UITableViewCell *cell = (UITableViewCell *) %orig();
	cell.backgroundColor = [UIColor blackColor];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.detailTextLabel.textColor = [UIColor whiteColor];
	return cell;
}

%end

/*
%hook TKPickerTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
	TKPickerTableViewCell *cell = (TKPickerTableViewCell *) %orig();
	cell.backgroundColor = [UIColor blackColor];
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.detailTextLabel.textColor = [UIColor whiteColor];
	return cell;
}

%end*/
