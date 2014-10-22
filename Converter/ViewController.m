//  ViewController.m
//
//  Copyright (c) 2014 Craft Inc (http://craftinc.co)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
    
    _convertButton.layer.cornerRadius = 5.0;
    
    // Symbols dictionary to format the output value
    _currencySymbols = @{@"GBP": @"£ ",
                         @"EUR": @"€ ",
                         @"JPY": @"¥ ",
                         @"BRL": @"$ "};
    
    _coinPouch = [[CoinPouch alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

/**
 Gets the amount value to convert and the country code represented in the segmented control selected index, instantiates a formatter and sets its properties including the currency symbol using the currencySymbols for propper output value formatting, finally converts the amount to the new currency and displays it.
 */

- (IBAction)convertCurrencyAction:(id)sender {
    NSString *amount = _amountTextField.text;
    NSString *code = [_currencySegmentedControl titleForSegmentAtIndex:[_currencySegmentedControl selectedSegmentIndex]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencySymbol:_currencySymbols[code]];
    
    NSString *currencyValue = [formatter stringFromNumber:[_coinPouch convertWith:amount for:code]];
    _currencyValueLabel.text = currencyValue;
}

/**
 Fetch the latest currency values from the API and updates the coins object showing a success of fail messages depending on the completion returned by the method.
 */

- (IBAction)reloadDataAction:(id)sender {
    [_coinPouch fetchDataWithCompletionBlock:^(BOOL success) {
        if (success) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Successful Update"
                                                                                     message:@"The currency data was successfuly updated."
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:nil];
            [alertController addAction:defaultAction];
            [self presentViewController:alertController animated:YES
                             completion:nil];
        } else {
            [self errorMessage];
        }
    }];
}

- (void)errorMessage {
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



@end
