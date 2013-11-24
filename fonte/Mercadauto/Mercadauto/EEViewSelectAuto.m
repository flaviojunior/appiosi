//
//  EEViewSelectAuto.m
//  Mercadauto
//
//  Created by Pedro Farias Barbosa on 24/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEViewSelectAuto.h"
#import "EECellOpcoesFiltro.h"

@interface EEViewSelectAuto ()

@end

@implementation EEViewSelectAuto

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableFiltro])
        return 3;
    
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableFiltro])
    {
        static NSString *CellIdentifier = @"EECellOpcoesFiltro";
    
        EECellOpcoesFiltro *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        if (cell == nil)
        {
        
            cell = [[EECellOpcoesFiltro alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    
        if (indexPath.row == 0)
        {
            cell.labelName.text = @"Marca:";
        }
        else
        {
            if (indexPath.row == 1)
            {
                 cell.labelName.text = @"Modelo:";
            }
            else
            {
                if (indexPath.row == 2)
                {
                 cell.labelName.text = @"Ano:";
                }
            }
        }
        
        return cell;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

@end
