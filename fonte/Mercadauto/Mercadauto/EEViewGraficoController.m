//
//  EEViewGraficoController.m
//  Mercadauto
//
//  Created by Fabio Marinho on 26/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEViewGraficoController.h"
#import "EERestUtil.h"


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
    
    [self buscaDadosPlotagem];
    
    coresGrafico = [NSArray arrayWithObjects:[CPTColor blueColor],[CPTColor redColor], [CPTColor greenColor], [CPTColor blackColor],nil];
    
    NSArray *arrayMeses = [self getArrayMeses];
    
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
    graph.plotAreaFrame.paddingBottom = 25.0;
    graph.plotAreaFrame.paddingLeft   = 50.0;
    graph.plotAreaFrame.paddingRight  = 0.0;
    
    // Setup plot space
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = NO;
    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(5.5)];
    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(max+50000)];
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    
    [self configuraEixoX:axisSet arrayLabels:arrayMeses];
    
    [self configuraEixoY:axisSet];
    
    
    [self geraValoresGrafico: arrayMeses];
    
}

-(void) configuraEixoX:(CPTXYAxisSet *) axisSet arrayLabels:(NSArray *) xAxisLabels{
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromString(@"1");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0.0");
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
    
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color = [CPTColor blackColor];
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    x.labelTextStyle = hitAnnotationTextStyle;

    
    NSUInteger labelLocation = 0;
    NSMutableArray *customLabels = [NSMutableArray arrayWithCapacity:[xAxisLabels count]];
    for (NSNumber *tickLocation in customTickLocations) {
        
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc]
                                  initWithText: [[xAxisLabels objectAtIndex:labelLocation++] objectForKey:@"nome"]
                                  textStyle:x.labelTextStyle];
        newLabel.tickLocation = [tickLocation decimalValue];
        newLabel.offset = x.labelOffset;
        newLabel.rotation = M_PI/4;
        [customLabels addObject:newLabel];
        //[newLabel release];
    }
    
        x.axisLabels =  [NSSet setWithArray:customLabels];
}

-(void) configuraEixoY:(CPTXYAxisSet *) axisSet{
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength         = CPTDecimalFromString(@"20000");

    y.minorTicksPerInterval       = 0;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    y.labelExclusionRanges = [NSArray arrayWithObject:
                              [[CPTPlotRange alloc] initWithLocation:CPTDecimalFromFloat(-1000000) length:CPTDecimalFromFloat(1000000)]
                              ];
    y.delegate             = self;
    NSNumberFormatter *nsf = [[NSNumberFormatter alloc] init];
    [nsf setGeneratesDecimalNumbers:NO];
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color = [CPTColor blackColor];
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    y.labelFormatter = nsf;
    y.labelTextStyle = hitAnnotationTextStyle;
}


- (void) geraValoresGrafico:(NSArray *) arrayMeses{
    
    
    //Coloca dados em estrutura mais fácil para plotagem...
   dadosTratados = [NSMutableDictionary dictionaryWithCapacity:4];
    
    NSMutableArray *veiculos = [self.dataForPlot objectForKey:@"veiculos"];
    
    for(NSDictionary *v in veiculos){
        NSString *modelo = [v objectForKey:@"modelo"];
        NSString *ano = [v objectForKey:@"ano_versao"];
        NSMutableString *label = [NSMutableString stringWithString:modelo ];
        [label appendString:@" - "];
        [label appendString:ano];
        
        // *** Iterar sobre as tendencias valores
        [self criaTendencia:label cor:[coresGrafico objectAtIndex:[veiculos indexOfObject:v]%4]];
        
        
        NSMutableArray *valores = [v objectForKey:@"grafico"];
        NSMutableArray *pontos =[NSMutableArray arrayWithCapacity:6];
        
        [dadosTratados setObject:pontos forKey:label];
        
        int count = 0;
        for (NSDictionary *mes in arrayMeses){
            //recupera mes e valor
            NSString *mesREST = [mes objectForKey:@"nomeREST"];
            NSString *valor = nil;
            BOOL existe = NO;
            for (NSDictionary *ponto in valores){
                //recupera mes e valor
                NSString *nomemes = [ponto objectForKey:@"mes"];
                if ([nomemes isEqual:mesREST]){
                    existe = YES;
                    valor = [ponto objectForKey:@"valor"];
                    break;
                }
            }
            id x = [NSNumber numberWithFloat:count++];
            id y =  (existe) ? [NSNumber numberWithFloat:[valor floatValue]] : nil;
            
            [pontos addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
            
        }
        
        
        
    }

}

- (NSArray *) getArrayMeses{
    
    NSDate *data = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *componenteMes = [[NSDateComponents alloc]init];
    componenteMes.month = -1;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    NSMutableArray *meses = [NSMutableArray arrayWithCapacity:6 ];
    
    for (int i=0;i<6;i++){
        NSMutableDictionary *mes = [[NSMutableDictionary alloc] init];
        NSString *nomeMes = [formatter stringFromDate:data];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:data];
        NSArray *mesesREST = [NSArray arrayWithObjects:@"JAN",@"FEV",@"MAR",@"ABR",@"MAI",@"JUN",@"JUL",@"AGO",@"SET",@"OUT",@"NOV",@"DEZ",nil];
        
        int indiceMes = [components month]-1;
        int ano = [components year];
        
        
        NSString *mesREST = [mesesREST objectAtIndex:indiceMes];
        
        NSString *nomeREST = [NSString stringWithFormat:@"%@/%4d",mesREST,ano];
        
        [mes setObject:nomeREST forKey:@"nomeREST"];
        [mes setObject:nomeMes forKey:@"nome"];
        
        
        data = [gregorian dateByAddingComponents:componenteMes toDate:data options:0];
        [meses addObject:mes];
        
    }
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
    boundLinePlot.delegate = self;
    NSNumberFormatter *nsf = [[NSNumberFormatter alloc] init];
    [nsf setGeneratesDecimalNumbers:NO];

    boundLinePlot.labelFormatter = nsf;
    CPTMutableTextStyle *hitAnnotationTextStyle = [CPTMutableTextStyle textStyle];
    hitAnnotationTextStyle.color = [CPTColor brownColor];
    hitAnnotationTextStyle.fontSize = 10.0f;
    hitAnnotationTextStyle.fontName = @"Helvetica-Bold";
    
    boundLinePlot.labelTextStyle = hitAnnotationTextStyle;
    [graph addPlot:boundLinePlot];
    
    // Add plot symbols
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = cor;
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:cor];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    boundLinePlot.plotSymbol = plotSymbol;
}


-(NSMutableArray *)obterDadosParaGrafico: (NSString *) identificador
{
    NSMutableArray *pontos = [dadosTratados objectForKey:identificador];
    
    if (pontos != nil){
        return pontos;
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

-(void) buscaDadosPlotagem{
    NSString *url = @"http://www.flaviojunior.com.br/mercadauto/json/jsongraph.php?v=3322,1111,2000,2122";
    dataForPlot = [EERestUtil request:url];
    min = [[[dataForPlot objectForKey:@"limites"] objectForKey:@"valorMinimo"] intValue];
    max = [[[dataForPlot objectForKey:@"limites"] objectForKey:@"valorMaximo"] intValue];
}

-(void) setDadosComparacao:(NSMutableArray *) v{
    modelosPesquisa = v;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num = [[[self obterDadosParaGrafico:plot.identifier] objectAtIndex:index] valueForKey:key];
    
    return num;
}



@end
