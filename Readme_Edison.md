### Edison QuickStart

(useful for bbook chapter IoT)

- Plug 2 micro usb cables in the two ports (power and programming micro usb ports)
Steps
- Insert a led in the Arduino pins 13 and GND (led anode, +, longer end, goes into 13, shorter end into GND next to the digital pin 13)
- Insert micro SD card (optional)
- Download XDK IoT edition from: https://software.intel.com/en-us/iot/software/ide
- Install XDK
- Select DigitalWrite template
- Change to pin 13
- Connect via screen `sudo screen /dev/ttyUSB0 115200`
- Edison configure wifi `edison --configure-wifi`
- Put IP into SDK
- Connect to Board
- Update firmware (optional but recommended, just do it once in a while)
- Run sketch

(the led should start blinking)
