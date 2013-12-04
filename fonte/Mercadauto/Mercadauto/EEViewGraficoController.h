//
//  EEViewGraficoController.h
//  Mercadauto
//
//  Created by Fabio Marinho on 26/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface EEViewGraficoController : UIViewController<CPTPlotDataSource, CPTScatterPlotDelegate, CPTPlotSpaceDelegate>{
    CPTXYGraph *graph;
    NSMutableArray *modelosPesquisa;
    NSArray *coresGrafico;
    NSMutableDictionary *dataForPlot;
    NSMutableDictionary *dadosTratados;
    CPTPlotSpaceAnnotation *symbolTextAnnotation;
    int max,min;
}

@property (readwrite, strong, nonatomic) NSMutableDictionary *dataForPlot;

-(void) setDadosComparacao:(NSMutableArray *) modelosPesquisa;

@end
