//
//  ViewController.m
//  Converter
//
//  Created by David Gómez on 10/21/14.
//  Copyright (c) 2014 Craft Inc. All rights reserved.
//

#import "ViewController.h"
#import "APIManager.h"
#import "CoinPouch.h"

@interface ViewController ()

@property (nonatomic) CoinPouch *coinPouch;

@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySegmentedControl;
@property (weak, nonatomic) IBOutlet UIButton *convertButton;
@property (weak, nonatomic) IBOutlet UILabel *currencyValueLabel;

@property (nonatomic) NSDictionary *currencySymbols;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Rounded corners for Convert button
    _convertButton.layer.cornerRadius = 5.0;
    
    // Symbols dictionary to format the output value
    _currencySymbols = @{@"GBP": @"£ ",
                         @"EUR": @"€ ",
                         @"JPY": @"¥ ",
                         @"BRL": @"$ "};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)convertCurrency:(id)sender {
    if (!_coinPouch) {
        _coinPouch = [[CoinPouch alloc] initWithCompletionBlock:^(BOOL success) {
            if (success) {
                [self convertCurrency];
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Connection Failed"
                                                                                         message:@"We couldn't get the currency values\n please try again later."
                                                                                  preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                        style:UIAlertActionStyleDefault
                                                                      handler:nil];
                [alertController addAction:defaultAction];
                [self presentViewController:alertController animated:YES
                                 completion:nil];
            }
        }];
    } else {
        [self convertCurrency];
    }
}

- (void)convertCurrency {
    // Set the amount and code strings to convert
    NSString *amount = _amountTextField.text;
    NSString *code = [_currencySegmentedControl titleForSegmentAtIndex:[_currencySegmentedControl selectedSegmentIndex]];
    
    // Create the formatter for the output value
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle: NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:_currencySymbols[code]];
    
    // Convert and display the computed value
    NSString *currencyValue = [formatter stringFromNumber:[_coinPouch convertWith:amount for:code]];
    _currencyValueLabel.text = currencyValue;
}

@end
