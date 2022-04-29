#!/usr/bin/env python
# coding: utf-8


import param
import json
import panel as pn

from panel.reactive import ReactiveHTML

class JSpreadsheet(ReactiveHTML):
    
    __javascript__ = ["https://bossanova.uk/jspreadsheet/v4/jexcel.js"
                     ,"https://jsuites.net/v4/jsuites.js"]
    
    __css__ = ["https://bossanova.uk/jspreadsheet/v4/jexcel.css"
              ,"https://jsuites.net/v4/jsuites.css"]
    
    ssdata_init = param.List(default=[
                ['Mazda', 2001, 2000],
                ['Pegeout', 2010, 5000],
                ['Honda Fit', 2009, 3000],
                ['Honda CRV', 2010, 6000]
            ])

    ssdata_out = param.List(default=[
                ['Mazda', 2001, 2000],
                ['Pegeout', 2010, 5000],
                ['Honda Fit', 2009, 3000],
                ['Honda CRV', 2010, 6000]
            ])
    
    sscolumns = param.List(default = [
                    { 'title':'Model', 'width':300 },
                    { 'title':'Price', 'width':80 },
                    { 'title':'Model', 'width':100 }
    ])
    
    _extension_name = 'jspreadsheet'

    _template = """
        <div id='container'>
        </div>
    """
    _scripts = {
        'render':"""
                var changed = function(instance, cell, x, y, value) {
                    data.ssdata_out = instance.jexcel.getData();
                    
                };
                jspreadsheet(container, {
                    data:data.ssdata_init,
                    columns:data.sscolumns,
                    onchange: changed
                });
            """
    }
         
pn.extension('jspreadsheet')

datatest = [
                ['Purple', 2001, 2000],
                ['Pegeout', 2010, 5000],
                ['Honda Fit', 2009, 3000],
                ['Honda CRV', 2010, 6000]
            ]


test = JSpreadsheet(ssdata_init = datatest)

out = pn.pane.JSON(datatest, name='JSON', height=300, width=500)

button = pn.widgets.Button(name='Print Data', button_type='primary', width = 200)

x = pn.Column(test,button, out)

def print_data(event):
    # print(test.ssdata)
    x[2] = pn.pane.JSON(test.ssdata_out, name='JSON', height=300, width=500)

button.on_click(print_data)

x.show()




