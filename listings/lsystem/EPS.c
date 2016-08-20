/*********************************************************
 * ���� EPS.c, ������� ��� ������ � EPS ������. 
 *********************************************************/ 
 #include  <stdio.h> 
 #include  <math.h>
 #include  <limits.h>
 #include  "EPS.h"
 #include  "Lsyst.h"
/*------------------------------------
 * ������������ ����������� ������� EPS-�����.
 *------------------------------------*/
 void  EPS_head_comments()
 {
 fprintf( eps.file, "%%!PS-Adobe-3.0 EPSF-3.0 \n"          );
 fprintf( eps.file, "%%%%BoundingBox: "                    );
 fprintf( eps.file, "% 20 d % 20 d ", eps.minX, eps.minY   );
 fprintf( eps.file, "% 20 d % 20 d \n", eps.maxX, eps.maxY );
 fprintf( eps.file, "%%%%Creator: GILGAMESH \n"            );
 fprintf( eps.file, "%%%%Title: "                          );
 fprintf( eps.file, "%s \n", eps.discription               );
 fprintf( eps.file, "%%%%Pages: 1\n"                       ); 
 fprintf( eps.file, "%%%%EndComments \n"                   );
 fprintf( eps.file, "3 setlinewidth \n"                    );   
 fprintf( eps.file, "newpath \n"                           );
 fprintf( eps.file, "0.0         0.0            moveto\n" ); 
 } 
/*------------------------------------
 * ������������ ����������� � ����� EPS-�����.
 *------------------------------------*/
 void  EPS_end_comment() 
 { 
 fprintf( eps.file, "stroke \n"         );
 fprintf( eps.file, "closepath \n"      );
 fprintf( eps.file, "%%%%Page: 1 1 \n" );
 fprintf( eps.file, "%%%%EOF \n"        );
 }
/*------------------------------------
 * ������������ "����" � ������� ����������.
 *------------------------------------*/
 void  EPS_movetoCurr()
 {
 fprintf( eps.file, "%- 16.4f %- 16.4f     moveto \n",
          eps.currX, eps.currY ); 
 }
/*------------------------------------
 * ������������ �� �������  ����� "����" �� ���������� segment
 * � ����������� initL.curr_Angle.
 *------------------------------------*/
 void  EPS_moveto()
 {
 double  x  = eps.segment*cos( initL.curr_Angle );
 double  y  = eps.segment*sin( initL.curr_Angle ); 
 eps.currX += x;
 eps.currY += y;
 min_max( eps.currX, eps.currY );     
 fprintf( eps.file, "%- 16.4f %- 16.4f     moveto \n",
          eps.currX, eps.currY ); 
 } 
/*------------------------------------
 * ������ ������� ����� segment �� �������  ����� � ��������-
 * ��� initL.curr_Angle.
 *------------------------------------*/ 
 void  EPS_lineto()
 {
 double  x  = eps.segment*cos( initL.curr_Angle );
 double  y  = eps.segment*sin( initL.curr_Angle );  
 eps.currX += x;
 eps.currY += y;
 min_max( eps.currX, eps.currY );   
 fprintf( eps.file, "%- 16.4f %- 16.4f    lineto \n", 
          eps.currX, eps.currY ); 
 } 
/*------------------------------------
 * ����������� ������� �������� ������ � ������ ��������,
 * ����� ��� ���������������.
 *------------------------------------*/  
 void  min_max( double  x, double  y )
 {
      if ( eps.minX > x )  eps.minX = x;
      if ( eps.maxX < x )  eps.maxX = x;
      if ( eps.minY > y )  eps.minY = y;
      if ( eps.maxY < y )  eps.maxY = y;                
 }        
/*------------------------------------
 * ��������� EPS ���� name_file ��� ������, ����� � ���� ����-
 * ����� ���� ������������. �������������� ���� eps.
 *------------------------------------*/       
 void  EPS_begin( char* name_file )
 {
 eps.file_name   = name_file;
 eps.discription = "������������ L-�������";
 eps.segment     = 100;         /* ����� ������� ���������   */
 eps.minX        = INT_MAX;     /* �������������             */
 eps.minY        = INT_MAX;     /* ��������                  */
 eps.maxX        = INT_MIN;     /* ��������                  */
 eps.maxY        = INT_MIN;     /* ��������                  */
 eps.currX       = 0.0;         /* ������� ��������          */ 
 eps.currY       = 0.0;         /* ��������� '����'          */
 min_max( eps.currX, eps.currY );
     if ( !( eps.file = fopen( eps.file_name, "w" ) ) )
     {
     printf( "�� ���� ������� ���� %s", eps.file_name );            
     exit( 1 );
     }  
 EPS_head_comments(); 
 }     
/*------------------------------------
 * ���������� � ����� EPS ����� �������������� ���� ������-
 * ������, ��������� ����, ����� ��������� ��� ������ ��-
 * �������� ����� ������������ � ������ ��������� ��������. 
 *------------------------------------*/       
 void  EPS_end()
 { 
 EPS_end_comment(); 
     if  ( fclose( eps.file ) )
     {
     printf( "�� ���� ������� ���� %s ", eps.file_name );
     abort();
     }
     else
     {    
         /* ������������� ������ ����� (����� ��� ����- */ 
         /* ����������� ��������)                       */ 
         if ( !( eps.file = fopen( eps.file_name, "r+" ) ) )
         {
         printf( "�� ���� ������� ���� %s ", eps.file_name );            
         exit( 1 );
         }  
         else  
         {
         eps.minX -= 5;   /* ��� �������      */
         eps.maxX += 5;   /* ����             */
         eps.minY -= 5;   /* �����������      */ 
         eps.maxY += 5;   /* ������� �������� */                
         EPS_head_comments( eps ); 
             if  ( fclose( eps.file ) )
             {                 
             printf( "�� ���� ������� ���� %s", eps.file_name );
             abort();
             }  
         }
     }                    
 } 
/** ����� ����� EPS.c **************************************/ 

