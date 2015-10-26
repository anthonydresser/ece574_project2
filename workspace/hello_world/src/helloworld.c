/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xparameters.h" // add
#include "xiomodule.h" // add

const int sineArray[] = {128, 76, 33, 6, 1, 17, 53, 101, 154, 202, 238, 254, 249, 222, 179, 128};
const int triArray[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};

int main()
{
	 int counter = 0, i = 0;
	 init_platform();
	 int temp = 0;
	 int temptemp = 0;
	 u32 data;
	 XIOModule gpi;
	 XIOModule gpo;
	 xil_printf("Reading switches and writing to LED port\n\r");
	 data = XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
	 data = XIOModule_Start(&gpi);
	 data = XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
	 data = XIOModule_Start(&gpo);
	 while (1)
	 {
		 if(counter == 9){
			 counter = 0;
			 XIOModule_DiscreteWrite(&gpo, 1, triArray[i]);
			 if(i > 15){
				 i = 0;
			 } else {
				 i++;
			 }
		 } else {
			 counter++;
		 }
		 temptemp = XIOModule_DiscreteRead(&gpi, 1); // read switches (channel 1)
		 if(temptemp != temp){
			 temp = temptemp;
			 xil_printf("temperature is %d\n", temp);
		 }

	 }

	 cleanup_platform();
	 return 0;
}
