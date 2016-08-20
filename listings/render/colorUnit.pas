 // ���� colorUnit.pas
 unit colorUnit;
 interface
 uses math;
 //----------------------------------
 type  Tcvet =  record             // ���� ��� ������
                R, G, B : integer; // ����� Red, Green,
                end;               // Blue;
 //== ���������� � ���������� ������: ============
 function  mix_colors( c_1, c_2: Tcvet ): Tcvet;
 function  mult_colors( color : Tcvet; k: double ): �����;
 //----------------------------------
 implementation
 //----------------------------------
 function  mix_colors( c_1, c_2: Tcvet ): Tcvet;
 var  c: Tcvet;
 begin
 c.R    := ( c_1.R + c_2.R ) div 2 mod 256;
 c.G    := ( c_1.G + c_2.G ) div 2 mod 256;
 c.B    := ( c_1.B + c_2.B ) div 2 mod 256;
 result := c;
 end;
 //----------------------------------
 function  mult_colors( color : Tcvet; k: double ): Tcvet;
 begin
 color.R :=  floor( abs( k*color.R ) ) mod 256;
 color.G :=  floor( abs( k*color.G ) ) mod 256;
 color.B :=  floor( abs( k*color.B ) ) mod 256;
 result  :=  color;
 end;
 end. // ����� ����� colorUnit.pas
