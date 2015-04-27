//
//  ViewController.h
//  CVC
//
//  Created by Francisco Canseco on 25/03/15.
//  Copyright (c) 2015 Francisco Canseco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnprof;
@property (strong, nonatomic) IBOutlet UILabel *lbProfesion;
- (IBAction)guardar:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *uvAgrega;
- (IBAction)btnProfesion:(id)sender;
- (IBAction)guardarplist:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbFechaIn;
@property (strong, nonatomic) IBOutlet UILabel *lbFOut;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)guardarFecha:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIDatePicker *dtPicker;
@property (strong, nonatomic) IBOutlet UITextField *tfMeta;
@property (strong, nonatomic) IBOutlet UIView *uvDate;
- (IBAction)cancelar:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *tfObjetivo;
- (IBAction)mostrar:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *tvIndicador;
- (IBAction)agregar:(id)sender;
- (IBAction)endDate:(id)sender;
- (IBAction)initialDate:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *tvAccion;
@end

