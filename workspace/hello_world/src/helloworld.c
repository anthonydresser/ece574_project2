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

const u8 sineArray[16] = {64, 88, 109, 123, 127, 123, 109, 88, 64, 40, 19, 5, 0, 5, 19, 40};
const u8 triArray[16] = {16, 32, 48, 64, 80, 96, 112, 127, 112, 96, 80, 64, 48, 32, 16, 0};
XIOModule gpi, gpo;
u8 i = 0;
u8 arrayFlag = 0;

void syncHandler(){
	if(arrayFlag == 0){
		XIOModule_DiscreteWrite(&gpo, 1, sineArray[i]);
		i = (i + 1) % 16;
	} else {
		XIOModule_DiscreteWrite(&gpo, 1, triArray[i]);
		i = (i + 1) % 16;
	}
}

void rxHandler(){
	u8 rx_buf;
	XIOModule_Recv(&gpo, &rx_buf, 1);
	if(rx_buf == 's'){
		xil_printf("Sine Wave @ 10KHz\n\r");
		arrayFlag = 0;
	} else if(rx_buf == 't'){
		xil_printf("Triangle Wave @ 10KHz\n\r");
		arrayFlag = 1;
	}
}

void timerTick(){
	xil_printf("Temperature %d.%d\n\r", (short) ((XIOModule_DiscreteRead(&gpi, 1)/128.0)*1.8 + 32.0)); // read switches (channel 1)
}

int main()
{
	 init_platform();

	 XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
	 XIOModule_Start(&gpi);
	 XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
	 XIOModule_Start(&gpo);

	 microblaze_register_handler(XIOModule_DeviceInterruptHandler, XPAR_IOMODULE_0_DEVICE_ID);

	 XIOModule_Connect(&gpo, XIN_IOMODULE_FIT_1_INTERRUPT_INTR, timerTick,
	                    NULL); // register timerTick() as our interrupt handler
	 XIOModule_Enable(&gpo, XIN_IOMODULE_FIT_1_INTERRUPT_INTR); // enable the interrupt

	 XIOModule_Connect(&gpo, XIN_IOMODULE_UART_RX_INTERRUPT_INTR, rxHandler,
			  	  	  	NULL);
	 XIOModule_Enable(&gpo, XIN_IOMODULE_UART_RX_INTERRUPT_INTR); // enable the interrupt

	 XIOModule_Connect(&gpo, XIN_IOMODULE_EXTERNAL_INTERRUPT_INTR, syncHandler,
	  			  	  	  	NULL);
	 XIOModule_Enable(&gpo, XIN_IOMODULE_EXTERNAL_INTERRUPT_INTR); // enable the interrupt

	 microblaze_enable_interrupts();
	 xil_printf("Anthony Dresser, November 6, 2015\n\r");
	 while (1)
	 {}

	 cleanup_platform();
	 return 0;
}
