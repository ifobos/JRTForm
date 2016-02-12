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

#import "JRTFormMapPickerViewController.h"

@interface JRTFormMapPickerViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *mapContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) MKMapView *mapView;
@end

@implementation JRTFormMapPickerViewController


+ (MKMapView *)sharedInstance {
    static dispatch_once_t once;
    static MKMapView *sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [MKMapView new];
    });
    
    return sharedInstance;
}

- (MKMapView *)mapView {
    if (!_mapView) {
        _mapView = [JRTFormMapPickerViewController sharedInstance];
        MKCoordinateRegion worldRegion = MKCoordinateRegionForMapRect(MKMapRectWorld);
        [_mapView setRegion:worldRegion animated:NO];
        if ([_mapView.annotations count] > 0) {
            [_mapView removeAnnotations:_mapView.annotations];
        }
        [_mapView removeConstraints:_mapView.constraints];
    }
    return _mapView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.title;
    self.mapView.delegate = self;
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(addAnotationFromGesture:)];
    gesture.minimumPressDuration = 1.0;
    [self.mapView addGestureRecognizer:gesture];
    [self showMapView];
    [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.delegate.coordinate.latitude != 0 && self.delegate.coordinate.longitude != 0) {
        [self addAnotationForCoordinate:self.delegate.coordinate];
    }
}


- (void)showMapView {
    self.mapView.frame = self.mapContainer.bounds;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.mapContainer addSubview:self.mapView];
}

- (void)addAnotationFromGesture:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        return;
    }
    CGPoint touchPoint = [gestureRecognizer locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView];
    [self addAnotationForCoordinate:coordinate];
}

- (void)addAnotationForCoordinate:(CLLocationCoordinate2D)coordinate {
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKPointAnnotation *anotation = [[MKPointAnnotation alloc] init];
    anotation.coordinate = coordinate;
    [self.mapView addAnnotation:anotation];
    [self.mapView
     setRegion:[self.mapView regionThatFits:MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.005, 0.005))]
     animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *pinView = nil;
    if (annotation != mapView.userLocation) {
        static NSString *defaultPin = @"pinIdentifier";
        pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPin];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPin];
        }
        pinView.draggable = YES;
        pinView.animatesDrop = YES;
    }
    return pinView;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)done:(id)sender {
    if ([self.mapView.annotations count] == 1) {
        MKPointAnnotation *anotation = [self.mapView.annotations firstObject];
        self.delegate.coordinate = anotation.coordinate;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
