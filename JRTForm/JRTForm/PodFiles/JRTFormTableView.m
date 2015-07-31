//Copyright (c) 2015 Juan Carlos Garcia Alfaro. All rights reserved.
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.


#import "JRTFormTableView.h"

@interface JRTFormTableView ()<UITableViewDelegate>
@property (nonatomic, strong) id<UITableViewDelegate> asignedDelegate;
@end

@implementation JRTFormTableView

- (void)didMoveToSuperview
{
    if (!self.delegate) {
        self.delegate = self;
    }
}

#pragma mark - Setters

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if ([delegate isEqual:self])
        self.asignedDelegate = nil;
    else
        self.asignedDelegate = delegate;
    [super setDelegate:self];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)])
        [self.asignedDelegate tableView:tableView willDisplayHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)])
        [self.asignedDelegate tableView:tableView willDisplayFooterView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)])
        [self.asignedDelegate tableView:tableView didEndDisplayingHeaderView:view forSection:section];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)])
        [self.asignedDelegate tableView:tableView didEndDisplayingFooterView:view forSection:section];
}

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    else return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
        return [self.asignedDelegate tableView:tableView heightForHeaderInSection:section];
    else return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
        return [self.asignedDelegate tableView:tableView heightForFooterInSection:section];
    else return UITableViewAutomaticDimension;
}


// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    else return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
        return [self.asignedDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
    else return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
        return [self.asignedDelegate tableView:tableView estimatedHeightForFooterInSection:section];
    else return UITableViewAutomaticDimension;
}

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)])
        return [self.asignedDelegate tableView:tableView viewForHeaderInSection:section];
    else return nil;
}   // custom view for header. will be adjusted to default or specified header height

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)])
        return [self.asignedDelegate tableView:tableView viewForFooterInSection:section];
    else return nil;
}   // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).

//- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0)
//{
//    return [self.delegate tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
//}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)])
        [self.asignedDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    else return NO;
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didHighlightRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView willSelectRowAtIndexPath:indexPath];
    else return nil;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView willDeselectRowAtIndexPath:indexPath];
    else return indexPath;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    else return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    else return nil;
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView editActionsForRowAtIndexPath:indexPath];
    else return nil;
} // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    else return NO;
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)])
        [self.asignedDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)])
        return [self.asignedDelegate tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    else return proposedDestinationIndexPath;
}

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    else return 0;
} // return 'depth' of row for hierarchies

// Copy/Paste.  All three methods must be implemented by the delegate.

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)])
        return [self.asignedDelegate tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    else return NO;
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)])
        return [self.asignedDelegate tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    else return NO;
}
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender NS_AVAILABLE_IOS(5_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)])
        [self.asignedDelegate tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
}


@end
