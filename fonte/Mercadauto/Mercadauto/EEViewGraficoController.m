//
//  EEViewGraficoController.m
//  Mercadauto
//
//  Created by Fabio Marinho on 26/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEViewGraficoController.h"


@implementation EEViewGraficoController

@synthesize dataForPlot;

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark Initialization and teardown


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Create graph from theme
    graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    [graph applyTheme:theme];
    CPTGraphHostingView *hView = [[CPTGraphHostingView alloc] init];
    self.view = hView;
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)self.view;
    
    //hostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    hostingView.hostedGraph     = graph;
    
    graph.paddingLeft   = 0.0;
    graph.paddingTop    = 0.0;
    graph.paddingRight  = 0.0;
    graph.paddingBottom = 0.0;
    
    graph.plotAreaFrame.paddingTop    = 0.0;
    graph.plotAreaFrame.paddingBottom = 50.0;
    graph.plotAreaFrame.paddingLeft   = 45.0;
    graph.plotAreaFrame.paddingRight  = 25.0;
    
    // Setup plot space
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(5.5)];
    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(200.0)];
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromString(@"1");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    x.minorTicksPerInterval       = 0;
    
    //Eixo com os meses
    // Define some custom labels for the data elements
    x.labelRotation = M_PI/4;
    x.labelingPolicy = CPTAxisLabelingPolicyNone;
    NSArray *customTickLocations = [NSArray
                                    arrayWithObjects:[NSDecimalNumber numberWithInt:0],
                                    [NSDecimalNumber numberWithInt:1],
                                    [NSDecimalNumber numberWithInt:2],
                                    [NSDecimalNumber numberWithInt:3],
                                    [NSDecimalNumber numberWithInt:4],
                                    [NSDecimalNumber numberWithInt:5],
                                    nil];
    
    NSArray *xAxisLabels = [self getArrayMeses];
    
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
    for (NSNumber *tickLocation in customTickLocations) {
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText: [xAxisLabels objectAtIndex:labelLocation++] textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset + x.majorTickLength;
        newLabel.rotation = M_PI/4;
        [customLabels addObject:newLabel];
        //[newLabel release];
    }
    
    x.axisLabels =  [NSSet setWithArray:customLabels];
    
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength         = CPTDecimalFromString(@"10");
    y.minorTicksPerInterval       = 0;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    
    
    y.delegate             = self;
    
    
    // *** Iterar sobre as tendencias valores
    [self criaTendencia:@"Modelo" cor:[CPTColor redColor]];
    
    // Add some initial data
    NSMutableArray *contentArray = [NSMutableArray arrayWithCapacity:100];
    NSUInteger i;
    for ( i = 0; i < 6; i++ ) {
        id x = [NSNumber numberWithFloat:i];
        id y = [NSNumber numberWithFloat:i*i];
        //[contentArray addObject:[NSMutableDictionary tableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    self.dataForPlot = contentArray;

    // *******************************************
    
	// Do any additional setup after loading the view.
}

- (NSArray *) getArrayMeses{
    
    NSDate *data = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSMonthCalendarUnit) fromDate:data];
    NSInteger month = [dateComponents month];
    
    NSDateComponents *componenteMes = [[NSDateComponents alloc]init];
    componenteMes.month = -1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    NSMutableArray *meses = [NSMutableArray arrayWithCapacity:6 ];
    
    for (int i=0;i<6;i++){
        NSString *nomeMes = [formatter stringFromDate:data];
        data = [gregorian dateByAddingComponents:componenteMes toDate:data options:0];
        [meses addObject:nomeMes];
    }
    
    //[data ]
    
    
    
    
    
    
    //NSDictionary *nomeMeses = [NSDictionary dictionaryWithObjectsAndKeys:@"Jan",1,@"Jan",1, nil];
    
    
    
    //NSArray *meses = [NSArray arrayWithObjects:@"Jan", @"Fev", @"Mar", @"Abr", @"Mai",@"Jun", @"Jul",
     //                       @"Ago", @"Set", @"Out",@"Nov",@"Dez", nil];
    return [[meses reverseObjectEnumerator] allObjects];
}

- (void) criaTendencia:(NSString *) idTendencia cor:(CPTColor *) cor {
    // Create a blue plot area
    CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit        = 1.0f;
    lineStyle.lineWidth         = 2.0f;
    lineStyle.lineColor         = cor;
    boundLinePlot.dataLineStyle = lineStyle;
    boundLinePlot.identifier    = idTendencia;
    boundLinePlot.dataSource    = self;
    [graph addPlot:boundLinePlot];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    boundLinePlot.plotSymbol = plotSymbol;
}


-(NSMutableArray *)obterDadosParaGrafico: (NSString *) identificador
{
    if ([identificador isEqual:@"Modelo"]){
        return dataForPlot;
    }else{
        return [[NSMutableArray alloc] init];
    }
    
}

//-(void)changePlotRange
//{
//    // Setup plot space
//    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
//    
//    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(3.0 + 2.0 * rand() / RAND_MAX)];
//    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(3.0 + 2.0 * rand() / RAND_MAX)];
//}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    
    return [[self obterDadosParaGrafico:plot.identifier] count];
    
}

-(void) setDadosComparacao:(NSMutableArray *) v{
    veiculos = v;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num = [[dataForPlot objectAtIndex:index] valueForKey:key];
    
    return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

//-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
//{
//    static CPTTextStyle *positiveStyle = nil;
//    static CPTTextStyle *negativeStyle = nil;
//    
//    NSFormatter *formatter = axis.labelFormatter;
//    CGFloat labelOffset    = axis.labelOffset;
//    NSDecimalNumber *zero  = [NSDecimalNumber zero];
//    
//    NSMutableSet *newLabels = [NSMutableSet set];
//    
//    for ( NSDecimalNumber *tickLocation in locations ) {
//        CPTTextStyle *theLabelTextStyle;
//        
//        if ( [tickLocation isGreaterThanOrEqualTo:zero] ) {
//            if ( !positiveStyle ) {
//                CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
//                newStyle.color = [CPTColor greenColor];
//                positiveStyle  = newStyle;
//            }
//            theLabelTextStyle = positiveStyle;
//        }
//        else {
//            if ( !negativeStyle ) {
//                CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
//                newStyle.color = [CPTColor redColor];
//                negativeStyle  = newStyle;
//            }
//            theLabelTextStyle = negativeStyle;
//        }
//        
//        NSString *labelString       = [formatter stringForObjectValue:tickLocation];
//        CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
//        
//        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
//        newLabel.tickLocation = tickLocation.decimalValue;
//        newLabel.offset       = labelOffset;
//        
//        [newLabels addObject:newLabel];
//    }
//    
//    axis.axisLabels = newLabels;
//    
//    return NO;
//}


@end
