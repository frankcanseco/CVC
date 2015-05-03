//
//  ViewController.m
//  CVC
//
//  Created by Francisco Canseco on 25/03/15.
//  Copyright (c) 2015 Francisco Canseco. All rights reserved.
//

#import "ViewController.h"
@interface celda : NSObject
@property NSString* meta;
@property NSString* objetivo;
@property NSString* accion;
@property NSString* indicador;
@property NSDate* inicio;
@property NSDate* fin;
@property NSInteger prof;
@property NSInteger estado;
@end
@implementation celda
@end
@interface ViewController ()
@property (strong,nonatomic) NSDate *fechaIn;
@property (strong,nonatomic) NSDate *fechaOut;
@property  NSInteger fech;
@property  NSInteger profesion;
@property NSMutableArray *celdas;
@property celda* celdaAux;
@property NSInteger state;
@property NSInteger order;
@property NSInteger estado;
@end
@implementation ViewController
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.uvAgrega.hidden = YES;
    self.uvDate.hidden = YES;
    self.celdas = [[NSMutableArray alloc] init];
    self.state = 0;
    self.infoCeldaOutlet.hidden = YES;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)initialDate:(id)sender {
    self.uvDate.hidden = NO;
    [self.dtPicker setDate:self.fechaIn];
    [self.scroll bringSubviewToFront:self.uvDate];
    self.fech = 1;
}
- (IBAction)endDate:(id)sender {
    self.uvDate.hidden = NO;
    [self.scroll bringSubviewToFront:self.uvDate];
    [self.dtPicker setDate:self.fechaOut];
    self.fech = 2;
}
- (IBAction)cancelar:(id)sender {
    [self.scroll bringSubviewToFront:self.uvDate];
    self.uvAgrega.hidden = YES;
    self.uvDate.hidden = YES;
}
- (IBAction)guardar:(id)sender {
    self.celdaAux =[[celda alloc]init];
    self.celdaAux.prof = self.profesion;
    self.celdaAux.inicio = self.fechaIn;
    self.celdaAux.fin = self.fechaOut;
    self.celdaAux.meta = self.tfMeta.text;
    self.celdaAux.objetivo = self.tfObjetivo.text;
    self.celdaAux.accion = self.tvAccion.text;
    self.celdaAux.indicador = self.tvIndicador.text;
    self.celdaAux.estado = self.estado;
    [self.celdas addObject:self.celdaAux];
    self.uvAgrega.hidden = YES;
    self.uvDate.hidden = YES;
    [self acomodarPorFecha];
    [self mostrar];
}
- (IBAction)agregar:(id)sender {
    self.tfMeta.text = @"";
    self.tfObjetivo.text = @"";
    self.tvAccion.text = @"";
    self.tvIndicador.text = @"";
    self.fechaIn =[NSDate date];
    self.fechaOut =[NSDate date];
    self.profesion = 0;
    self.estado = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.lbFechaIn.text = [dateFormatter stringFromDate:[NSDate date]];
    self.lbFOut.text =  [dateFormatter stringFromDate:[NSDate date]];
    self.lbProfesion.text = @"Profesional";
    [self.btnprof setImage:[UIImage imageNamed:@"Briefcase.png"] forState:UIControlStateNormal];
    [self.btnEstadoOutlet setImage:[UIImage imageNamed:@"cancelButton.png"] forState:UIControlStateNormal];
    self.uvAgrega.hidden = NO;
    [self.scroll bringSubviewToFront:self.uvAgrega];
}
- (IBAction)guardarFecha:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    if (self.fech == 1){
        self.fechaIn =self.dtPicker.date;
        self.lbFechaIn.text = [dateFormatter stringFromDate:self.dtPicker.date];
        if ([self.fechaIn compare: self.fechaOut]==NSOrderedDescending){
            self.fechaOut=self.fechaIn;
            self.lbFOut.text = [dateFormatter stringFromDate:self.dtPicker.date];
        }
    }
    else{
        self.fechaOut =self.dtPicker.date;
        self.lbFOut.text = [dateFormatter stringFromDate:self.dtPicker.date];
        if ([self.fechaIn compare: self.fechaOut]==NSOrderedDescending){
            self.fechaIn=self.fechaOut;
            self.lbFechaIn.text = [dateFormatter stringFromDate:self.dtPicker.date];
        }
    }
    self.fech = 0;
    self.uvDate.hidden = YES;
}
- (IBAction)btnProfesion:(id)sender {
    self.profesion = (self.profesion+1)%4;
    if (self.profesion == 0){
        [self.btnprof setImage:[UIImage imageNamed:@"Briefcase.png"] forState:UIControlStateNormal];
        self.lbProfesion.text = @"Profesional";
    }else{
        if (self.profesion == 1){
            [self.btnprof setImage:[UIImage imageNamed:@"oro.png"] forState:UIControlStateNormal];
            self.lbProfesion.text = @"Economico";
            
        }else{
            if (self.profesion == 2){
                [self.btnprof setImage:[UIImage imageNamed:@"peronal.png"] forState:UIControlStateNormal];
                self.lbProfesion.text = @"Personal";
                
            }else{
                [self.btnprof setImage:[UIImage imageNamed:@"brain.png"] forState:UIControlStateNormal];
                self.lbProfesion.text = @"Intelectual";
            }
        }
    }
}

- (IBAction)guardarplist:(id)sender {
    
}
-(void)acomodarPorFecha{
    NSSortDescriptor *fechin = [[NSSortDescriptor alloc] initWithKey:@"inicio" ascending:YES];
    NSSortDescriptor *fechter = [[NSSortDescriptor alloc] initWithKey:@"fin" ascending:YES];
    
    [self.celdas sortUsingDescriptors:[NSArray arrayWithObjects:fechin, fechter, nil]];
}
- (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}
- (void)mostrar{
    NSLocale *mxLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_MX"];

    NSDate* hoy = [NSDate date];
    for (UIView *subview in self.scroll.subviews) {
        if (subview != self.uvAgrega&& subview != self.uvDate&&subview!= self.infoCeldaOutlet.superview)
            [subview removeFromSuperview];
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setLocale:mxLocale];
    NSUInteger i;
    int xCoord=0;
    int yCoord=0;
    int buttonWidth=640;
    int buttonHeight=70;
    int buffer = 3;
    for (i = 0; i < self.celdas.count; i++)
    {
        NSInteger p =[self.celdas[i] prof];
        NSInteger e = [self.celdas[i] estado];
        UIButton *v = [[UIButton alloc]init];
        UILabel *lb1 = [[UILabel alloc]init];
        UILabel *lb2 = [[UILabel alloc]init];
        UILabel *lb3 = [[UILabel alloc]init];
        UIImage *img;
        UIImage *img2;

        UIView *v2 = [[UIView alloc]init];
        UIView *v3 = [[UIView alloc]init];
        lb1.text = [self.celdas[i] meta];
        lb2.text = [dateFormatter stringFromDate:[self.celdas[i] inicio]];
        lb3.text = [dateFormatter stringFromDate:[self.celdas[i] fin]];
        v2.frame =CGRectMake(xCoord+240, 0,100,buttonHeight );
        v3.frame =CGRectMake(xCoord+540, 0,100,buttonHeight );
        UIGraphicsBeginImageContext(v2.frame.size);
        if (p == 0){
            [[UIImage imageNamed:@"Briefcase.png"] drawInRect:v2.bounds];
        }else{
            if (p== 1){
                [[UIImage imageNamed:@"oro"] drawInRect:v2.bounds];
                
            }else{
                if (p == 2){
                    [[UIImage imageNamed:@"peronal.png"] drawInRect:v2.bounds];
                    
                }else{
                    [[UIImage imageNamed:@"brain.png"] drawInRect:v2.bounds];
                }
            }
        }
        
        [lb1 setNumberOfLines:0];
        [lb1 sizeToFit];
        [lb2 setNumberOfLines:0];
        [lb2 sizeToFit];
        [lb3 setNumberOfLines:0];
        [lb3 sizeToFit];
        lb1.frame =CGRectMake(xCoord, 0,240,buttonHeight );
        lb2.frame =CGRectMake(xCoord+340, 0,100,buttonHeight );
        lb3.frame =CGRectMake(xCoord+440, 0,100,buttonHeight );
        lb1.textAlignment = NSTextAlignmentCenter;
        lb2.textAlignment = NSTextAlignmentCenter;
        lb3.textAlignment = NSTextAlignmentCenter;
        [[UIImage imageNamed:@"image.png"] drawInRect:self.view.bounds];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        v2.contentMode = UIViewContentModeScaleAspectFit;
        v2.backgroundColor = [UIColor colorWithPatternImage:img];
        UIGraphicsBeginImageContext(v3.frame.size);
        if (e == 0){
            [[UIImage imageNamed:@"cancelButton.png"] drawInRect:v3.bounds];
        }else{
            [[UIImage imageNamed:@"acceptButton.png"] drawInRect:v3.bounds];
        }
        img2 = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        v3.contentMode = UIViewContentModeScaleAspectFit;
        v3.backgroundColor = [UIColor colorWithPatternImage:img2];
        [v addSubview:lb1];
        [v addSubview:lb2];
        [v addSubview:lb3];
        [v addSubview:v2];
        [v addSubview:v3];
        v.frame     = CGRectMake(xCoord, yCoord,buttonWidth,buttonHeight );
        if ([[self.celdas[i] fin] compare:hoy] == NSOrderedAscending) {
            v.backgroundColor = [UIColor colorWithRed:0.953 green:0.471 blue:0.443 alpha:.5];
        } else if ([[self.celdas[i] inicio] compare:hoy] == NSOrderedDescending) {
            v.backgroundColor =[UIColor colorWithRed:.8 green:.8 blue:0.263 alpha:.5];
            
        } else {
             v.backgroundColor = [UIColor colorWithRed:0.553 green:0.776 blue:0.251 alpha:.5];        }
        if ([self isSameDay:hoy otherDay:[self.celdas[i] fin]]){
            v.backgroundColor = [UIColor colorWithRed:0.553 green:0.776 blue:0.251 alpha:.5];
        }
        v.layer.cornerRadius = 15;
        [v addTarget:self action:@selector(checkButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [v setTag:i];
        [self.scroll addSubview:v];
        
        yCoord += buttonHeight + buffer;
    }
   
    [self.scroll setContentSize:CGSizeMake(640, yCoord)];
}
- (void)checkButtonTapped:(id)sender
{
    NSInteger t = [sender tag];
    self.state = 1;
    for (UIView *subview in self.scroll.subviews) {
        if (subview.tag == t){
            subview.alpha = 1;
            self.infoCeldaOutlet.hidden = NO;
            self.agregaOutlet.hidden = YES;
        }
        else{
            if (subview != self.uvAgrega&& subview != self.uvDate&&subview!= self.infoCeldaOutlet.superview){
                   subview.alpha = .5;
               }
        }
    }
    
}
-(IBAction)handleSingleTap:(UIGestureRecognizer*)sender
{
    if (self.state == 1){
        self.state = 0;
        for (UIView *subview in self.scroll.subviews) {
            subview.alpha = 1;
        }
        
    }
    self.infoCeldaOutlet.hidden = YES;
    self.agregaOutlet.hidden = NO;
}
- (IBAction)infoCelda:(id)sender {
}
- (IBAction)btnEstado:(id)sender {
    self.estado = (self.estado+1)%2;
    if (self.estado == 0){
        [self.btnEstadoOutlet setImage:[UIImage imageNamed:@"cancelButton.png"] forState:UIControlStateNormal];
    }else{
        [self.btnEstadoOutlet setImage:[UIImage imageNamed:@"acceptButton.png"] forState:UIControlStateNormal];
    }
}
@end
