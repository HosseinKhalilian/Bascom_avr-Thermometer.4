'======================================================================='

' Title: LCD Display Thermometer * Bar Scale
' Last Updated :  05.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega8 + LM35 + 20x4 Character lcd display

'======================================================================='

$regfile = "M8def.dat"
$crystal = 10000000

Deflcdchar 0 , 32 , 32 , 31 , 31 , 31 , 31 , 32 , 32        ' replace ? with number (0-7)'
Deflcdchar 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1                ' replace ? with number (0-7)
Deflcdchar 2 , 16 , 16 , 16 , 16 , 16 , 16 , 16 , 16        ' replace ? with number (0-7)
Deflcdchar 3 , 16 , 16 , 31 , 31 , 31 , 31 , 16 , 16        ' replace ? with number (0-7)
Deflcdchar 4 , 1 , 1 , 31 , 31 , 31 , 31 , 1 , 1            ' replace ? with number (0-7)
Deflcdchar 5 , 32 , 32 , 28 , 28 , 28 , 28 , 32 , 32        ' replace ? with number (0-7)

Config Lcdpin = Pin , Db4 = Portd.3 , Db5 = Portd.2 , Db6 = Portd.1 , Db7 = Portd.0 , E = Portd.6 , Rs = Portd.7
Config Lcd = 20 * 4

Config Adc = Single , Prescaler = Auto , Reference = Avcc   'config ADC

Start Adc

Dim W As Word
Dim Volt As Word
Dim Volt_d As Byte
Dim I As Byte
Dim Cols As Byte
Dim Cols_d As Byte

Cls
Cursor Off
Locate 3 , 1
Lcd "0"
Locate 3 , 5
Lcd "10"
Locate 3 , 10
Lcd "20"
Locate 3 , 15
Lcd "30"
Locate 3 , 19
Lcd Chr(223) ; "C"

'--------------------------------------------
Do

W = Getadc(0)
Volt = W * 5
Volt_d = Volt Mod 10
Volt = Volt / 10
Locate 1 , 1
Lcd Volt ; "," ; Volt_d

Cols = Volt / 2

Locate 2 , 1
For I = 1 To Cols

Select Case I
   Case 1 : Lcd Chr(3)
   Case 5 : Lcd Chr(4)
   Case 10 : Lcd Chr(4)
   Case 15 : Lcd Chr(4)
   Case 20 : Lcd Chr(4)
   Case Else : Lcd Chr(0)
End Select

Next I

Cols_d = Cols Mod 2
If Cols_d > 0 Then
Lcd Chr(5)
Cols = Cols + 2
Else
Cols = Cols + 1
End If

For I = Cols To 20
  Select Case I
   Case 1 : Lcd Chr(2)
   Case 5 : Lcd Chr(1)
   Case 10 : Lcd Chr(1)
   Case 15 : Lcd Chr(1)
   Case 20 : Lcd Chr(1)
   Case Else : Lcd Chr(32)
End Select
Next I

Waitms 1000
Loop
End

'------------------------------------------------