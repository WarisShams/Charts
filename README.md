Charts
======

PIE, Bar , Line and Doughnut Charts to use in any app.


PIE Chart:

// In your viewDidLoad method add this code.

```objective-c
 - (void)viewDidLoad
{
    [super viewDidLoad];
    
    PieChart *pie = [[PieChart alloc]initWithFrame:CGRectMake(10, 10, 300, 250)];
    
    [pie setOptions:@[@10,@30,@10,@10,@20,@60,@70]];
    [pie setTitleValues:@[@"2008",@"2009",@"2010",@"2011",@"2012",@"2013"]];
    [pie setSideValue_Bar:kSideValueBar_Show];
    [pie setSegment_Selection:kSegmentSelection_On];
    
    [self.view addSubview:pie];
}
```
Line Chart:
// In your viewDidLoad method add this code.

```objective-c
 - (void)viewDidLoad
{
    [super viewDidLoad];
    LineChartExp *line = [[LineChartExp alloc]initWithFrame:CGRectMake(10, 80, 300, 200)];
    [line setOptions:@[@[@"5",@"210",@"136",@"100",@"230",@"100",@"150",@"140"],
                       @[@"190",@"160",@"120",@"145",@"110",@"160",@"180",@"200",@"150",@"140",@"190",@"160"]]];
    [line setXAxisValues:@[@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014"]];
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
}
````

Bar Chart:
// In your viewDidLoad method add this code.

```objective-c
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BarChart *barBase = [[BarChart alloc]initWithFrame:CGRectMake(10, 80, 300, 200)];
    
    /*  Values is array of arrays.. if no group then use @[@[values....]] else use @[@[values of group1],@[values of group2]] :)*/
    //[barBase setValues:@[@[@"50",@"150",@"30"],@[@"80",@"70",@"50"],@[@"30",@"120",@"106"],@[@"125",@"45",@"50"],@[@"40",@"106",@"115"]]];
        [barBase setValues:@[@[@"50",@"150",@"30",@"80",@"70",@"50",@"30",@"120",@"106",@"125",@"45",@"50",@"40"]]];
    
    /* groupOrBarTitles is array of group titles in case of multiple group or bar x-axis value in other case :)*/
    [barBase setGroupOrBarTitles:@[@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2012",@"2013",@"2014"]];
    
    barBase.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barBase];
}
```

<br>
Pie Chart

<br>
![alt tag](https://github.com/WarisShams/Charts/blob/master/iOS%20Simulator%20Screen%20shot%2005-Sep-2014%203.25.51%20pm.png "Pie Chart")
<br>

Pie Chart Selection
<br>
![alt tag](https://github.com/WarisShams/Charts/blob/master/iOS%20Simulator%20Screen%20shot%2005-Sep-2014%203.25.59%20pm.png "Pie Chart Selection")
<br>

Line Chart
<br>
![alt tag](https://github.com/WarisShams/Charts/blob/master/iOS%20Simulator%20Screen%20shot%2005-Sep-2014%203.26.04%20pm.png "Line Chart")
<br>

Bar Chart
<br>
![alt tag](https://github.com/WarisShams/Charts/blob/master/iOS%20Simulator%20Screen%20shot%2005-Sep-2014%203.26.18%20pm.png "Bar Chart")
<br>

