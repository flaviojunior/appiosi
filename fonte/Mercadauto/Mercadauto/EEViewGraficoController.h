//
//  EEViewGraficoController.h
//  Mercadauto
//
//  Created by Fabio Marinho on 26/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface EEViewGraficoController : UIViewController<CPTPlotDataSource, CPTAxisDelegate>{
    CPTXYGraph *graph;
    NSMutableArray *veiculos;
    NSMutableArray *dataForPlot;
}

@property (readwrite, strong, nonatomic) NSMutableArray *dataForPlot;

-(void) setDadosComparacao:(NSMutableArray *) veiculos;

@end
