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
    NSMutableArray *modelosPesquisa;
    NSMutableDictionary *dataForPlot;
    NSMutableDictionary *dadosTratados;
    int max,min;
}

@property (readwrite, strong, nonatomic) NSMutableDictionary *dataForPlot;

-(void) setDadosComparacao:(NSMutableArray *) modelosPesquisa;

@end
