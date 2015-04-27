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
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.uvAgrega.hidden = YES;
    self.uvDate.hidden = YES;
    self.celdas = [[NSMutableArray alloc] init];
    
    
    
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
    [self.celdas addObject:self.celdaAux];
    self.uvAgrega.hidden = YES;
    self.uvDate.hidden = YES;
    
}
- (IBAction)agregar:(id)sender {
    self.tfMeta.text = @"";
    self.tfObjetivo.text = @"";
    self.tvAccion.text = @"";
    self.tvIndicador.text = @"";
    self.fechaIn =[NSDate date];
    self.fechaOut =[NSDate date];
    self.profesion = 0;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.lbFechaIn.text = [dateFormatter stringFromDate:[NSDate date]];
    self.lbFOut.text =  [dateFormatter stringFromDate:[NSDate date]];
    self.lbProfesion.text = @"Profesional";
    [self.btnprof setImage:[UIImage imageNamed:@"Briefcase.png"] forState:UIControlStateNormal];
    self.uvAgrega.hidden = NO;
    [self.scroll bringSubviewToFront:self.uvAgrega];
}
- (IBAction)guardarFecha:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    if (self.fech == 1){
        self.fechaIn =self.dtPicker.date;
        self.lbFechaIn.text = [dateFormatter stringFromDate:self.dtPicker.date];
    }
    else{
        self.fechaOut =self.dtPicker.date;
        self.lbFOut.text = [dateFormatter stringFromDate:self.dtPicker.date];
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
- (IBAction)mostrar:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSUInteger i;
    int xCoord=0;
    int yCoord=0;
    int buttonWidth=640;
    int buttonHeight=70;
    int buffer = 10;
    for (i = 0; i < self.celdas.count; i++)
    {
        NSInteger p =[self.celdas[i] prof];
        UIView *v = [[UIView alloc]init];
        UILabel *lb1 = [[UILabel alloc]init];
        UILabel *lb2 = [[UILabel alloc]init];
        UILabel *lb3 = [[UILabel alloc]init];
        UILabel *lb4 = [[UILabel alloc]init];
        UILabel *lb5 = [[UILabel alloc]init];
        UILabel *lb6 = [[UILabel alloc]init];
        UIImage *img;
        UIView *v2 = [[UIView alloc]init];
        v.backgroundColor = [UIColor greenColor];
        lb1.text = [self.celdas[i] meta];
        lb2.text = [self.celdas[i] objetivo];
        lb3.text = [self.celdas[i] accion];
        lb4.text = [self.celdas[i] indicador];
        UIFont *font = lb5.font;
        lb5.font = [font fontWithSize:11];
        lb6.font = [font fontWithSize:11];
        lb5.text = [dateFormatter stringFromDate:[self.celdas[i] inicio]];
        lb6.text = [dateFormatter stringFromDate:[self.celdas[i] fin]];
        v2.frame =CGRectMake(xCoord+113, 0,64,buttonHeight );
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
        lb1.frame =CGRectMake(xCoord, 0,113,buttonHeight );
        lb2.frame =CGRectMake(xCoord+177, 0,125,buttonHeight );
        lb3.frame =CGRectMake(xCoord+302, 0,118,buttonHeight );
        lb4.frame =CGRectMake(xCoord+420, 0,109,buttonHeight );
        lb5.frame =CGRectMake(xCoord+529, 0,56,buttonHeight );
        lb6.frame =CGRectMake(xCoord+585, 0,56,buttonHeight );
        [[UIImage imageNamed:@"image.png"] drawInRect:self.view.bounds];
        img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        v2.contentMode = UIViewContentModeScaleAspectFit;
        v2.backgroundColor = [UIColor colorWithPatternImage:img];
        [v addSubview:lb1];
        [v addSubview:lb2];
        [v addSubview:lb3];
        [v addSubview:lb4];
        [v addSubview:lb5];
        [v addSubview:lb6];
        [v addSubview:v2];
        v.frame     = CGRectMake(xCoord, yCoord,buttonWidth,buttonHeight );
        [self.scroll addSubview:v];
        
        yCoord += buttonHeight + buffer;
    }
    [self.scroll setContentSize:CGSizeMake(667, yCoord)];
}
@end
