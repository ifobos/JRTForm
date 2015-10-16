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

@end

@implementation JRTFormTableView

#pragma mark - View

- (void)didMoveToSuperview
{
    if (!self.delegate) {
        self.delegate = self;
    }
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if ([delegate isEqual:self])
        self.asignedDelegate = nil;
    else
        self.asignedDelegate = delegate;
    [super setDelegate:self];
}


#pragma mark - Helpers

- (id)formFieldCellWithNibName:(NSString *)JRTFormFieldTableViewCell andNameIdentifier:(NSString *)name
{
    [self registerNib:[UINib nibWithNibName:JRTFormFieldTableViewCell bundle:nil] forCellReuseIdentifier:name];
    JRTFormBaseCell *cell = [self dequeueReusableCellWithIdentifier:name];
    cell.name             = name;
    return cell;
}

- (JRTFormTextFieldTableViewCell *)formTextFieldTableViewCellWithName:(NSString*)name
{
    id cell =  [self formFieldCellWithNibName:kJRTFormFieldTextFieldTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormTextFieldTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldTextFieldTableViewCell]
                                          userInfo:nil];
}

- (JRTFormTextViewTableViewCell *)formTextViewTableViewCellWithName:(NSString*)name
{
    id cell = [self formFieldCellWithNibName:kJRTFormFieldTextViewTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormTextViewTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldTextViewTableViewCell]
                                          userInfo:nil];
}

- (JRTFormSelectTableViewCell *)formSelectTableViewCellWithName:(NSString*)name
{
    id cell = [self formFieldCellWithNibName:kJRTFormFieldSelectTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormSelectTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldSelectTableViewCell]
                                          userInfo:nil];
}

- (JRTFormSwitchTableViewCell *)formSwitchTableViewCellWithName:(NSString*)name
{
    id cell = [self formFieldCellWithNibName:kJRTFormFieldSwitchTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormSwitchTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldSwitchTableViewCell]
                                          userInfo:nil];
}

- (JRTFormMapTableViewCell *)formMapTableViewCellWithName:(NSString*)name
{
    id cell = [self formFieldCellWithNibName:kJRTFormFieldMapTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormMapTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldMapTableViewCell]
                                          userInfo:nil];
}

- (JRTFormSubmitButtonTableViewCell *)formSubmitButtonTableViewCellWithName:(NSString*)name
{
    id cell = [self formFieldCellWithNibName:kJRTFormFieldSubmitButtonTableViewCell andNameIdentifier:name];
    if ([cell isKindOfClass:[JRTFormSubmitButtonTableViewCell class]]) return cell;
    else @throw  [[NSException alloc] initWithName:[NSString stringWithFormat:@"%@", self.class]
                                            reason:[NSString stringWithFormat:@"%@, %@ is not a correct kind of class. ", NSStringFromSelector(_cmd), kJRTFormFieldSubmitButtonTableViewCell]
                                          userInfo:nil];
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
    else
        return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)])
        return [self.asignedDelegate tableView:tableView heightForHeaderInSection:section];
    else
        return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)])
        return [self.asignedDelegate tableView:tableView heightForFooterInSection:section];
    else
        return UITableViewAutomaticDimension;
}


// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0)
{
//    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)])
//        return [self.asignedDelegate tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
//    else
        return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)])
        return [self.asignedDelegate tableView:tableView estimatedHeightForHeaderInSection:section];
    else
        return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)])
        return [self.asignedDelegate tableView:tableView estimatedHeightForFooterInSection:section];
    else
        return UITableViewAutomaticDimension;
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



#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
        [self.asignedDelegate scrollViewDidScroll:scrollView];
}
// any offset changes

- (void)scrollViewDidZoom:(UIScrollView *)scrollView NS_AVAILABLE_IOS(3_2)
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidZoom:)])
        [self.asignedDelegate scrollViewDidZoom:scrollView];
}
// any zoom scale changes

// called on start of dragging (may require some time and or distance to move)
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
        [self.asignedDelegate scrollViewWillBeginDragging:scrollView];
}
// called on finger up if the user dragged. velocity is in points/millisecond. targetContentOffset may be changed to adjust where the scroll view comes to rest

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0)
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)])
        [self.asignedDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
}
// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
        [self.asignedDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
        [self.asignedDelegate scrollViewWillBeginDecelerating:scrollView];
}
// called on finger up as we are moving

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
        [self.asignedDelegate scrollViewDidEndDecelerating:scrollView];
}
// called when scroll view grinds to a halt

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
        [self.asignedDelegate scrollViewDidEndScrollingAnimation:scrollView];
}
// called when setContentOffset/scrollRectVisible:animated: finishes. not called if not animating

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
        return [self.asignedDelegate viewForZoomingInScrollView:scrollView];
    else return nil;
    
}
// return a view that will be scaled. if delegate returns nil, nothing happens

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2)
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
        [self.asignedDelegate scrollViewWillBeginZooming:scrollView withView:view];
    
}
// called before the scroll view begins zooming its content

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
        [self.asignedDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}
// scale between minimum and maximum. called after any 'bounce' animations

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
        return [self.asignedDelegate scrollViewShouldScrollToTop:scrollView];
    else return YES;
}
// return a yes if you want to scroll to the top. if not defined, assumes YES

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    if ([self.asignedDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
        [self.asignedDelegate scrollViewDidScrollToTop:scrollView];
    
}
// called when scrolling animation finished. may be called immediately if already at top



@end
