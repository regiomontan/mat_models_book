 /*********************************************************
  * ���� Lsystem.y. 
  * ���������� � ��������������� �������� ��� ���������� �
  * ����� L-������ �� EPS. ����� ��������� Bison'�� ���������-
  * ���� �������� ���� ���������. 
  *********************************************************/ 
 %{
  #include   <stdio.h>
  #include   <ctype.h>
  #include   "Lsyst.h"
  #include   "EPS.h"
  
  int     numb_symb = -1;    /* � ������� � ����. ������ */
  stack  *top_stack = NULL;
  const   double   PI = 3.14159265358979323846;               
 %}
 %% 
 str :   '['    str     ']'            
     |   str    '['     str   ']' 
     |   symb                  
     |   str    symb         
     ;
             
 symb :  'F'          { EPS_lineto();                         } 
      |  '+'          { initL.curr_Angle += initL.Angle;      }
      |  '-'          { initL.curr_Angle -= initL.Angle;      }
      |  '|'          { initL.curr_Angle = -initL.curr_Angle; } 
      |  'f'          { EPS_moveto();                         }
      ;
 %%
/*------------------------------------
 * ����������� ���������� 
 *------------------------------------*/
 yylex() 
 {
 ++numb_symb;        
 int c = initL.command[ numb_symb ];
    /* ������� �������� ��������� � ���� ������� � ����: */ 
     if ( initL.command[ numb_symb ] == '[' )
     {
     struct  CURR_DATA  curr_data;	
     curr_data.x    = eps.currX;
     curr_data.y    = eps.currY;
     curr_data.ugol = initL.curr_Angle;
     top_stack = new_link( top_stack, curr_data ); 
     }
    /* �������� ��������� � ���� ����������� �� �����    *
     * � ������ �� ��������:                             */ 
     if ( initL.command[ numb_symb ] == ']')
     {
     eps.currX        = top_stack->data.x;
     eps.currY        = top_stack->data.y;
     EPS_movetoCurr();
     initL.curr_Angle = top_stack->data.ugol;	
     top_stack        = delete_link( top_stack );       	
     }	
     if ( numb_symb == strlen( initL.command ) ) 
     return  0;     /* ����� �� ����� --- �������� ������ */
     else                                       
     return  c; 
 }
/*------------------------------------*/
 int main ( int argc, char* argv[] )
 {
     if ( argc < 4 )
     {
     printf( "�������� ���������, �����:\n" );
     printf( "L2eps.exe ���_L-�����.l ���_EPS-�����.eps " );
     printf( "Order Angle0\n" );
     printf( "������� <Enter>");	
     getchar();
     exit( 1 );
     }	
 char*   Lfile_name    = argv[1];
 char*   EPSfile_name  = argv[2];		
 int     Order         = atoi( argv[3] );
     if  ( argc == 5 )
     {
     double  ugol_0        = atof( argv[4] ); 
         if   ( ugol_0 )  initL.curr_Angle = PI/ugol_0;
         else             initL.curr_Angle = 0;   
     }   
     else   initL.curr_Angle = 0; 
 top_stack        = (stack*) malloc( sizeof ( stack ) );
 top_stack->link  = NULL;	
     if ( !read_Lsyst( Lfile_name, Order ) )
     {
     printf( "\nc����� ���� %s\n",  Lfile_name       );
     printf( "Order   = %d\n",      Order            ); 
     printf( "Angle0  = %f\n",      initL.curr_Angle );
     printf( "Angle   = %f\n",      initL.Angle      );
     printf( "Axiom   = '%c'\n",    initL.Axiom      );
     printf( "command = '%s'\n",    initL.command    );
        if ( !substitute( initL.Axiom, Order ) )
        {
        printf("����������� %d ���(�)\n", Order         ); 
        printf("command = '%s'\n",        initL.command );
        }
        else
        {
        printf( "���� ��� ����������� � ���. ������" );
        exit( 1 );
        }
     }
     else
     {
     printf( "���� ��� ������ ����� %s\n", Lfile_name );	
     exit( 1 );
     } 	
 printf( "������� ������ EPS �����\n" );    
 EPS_begin( EPSfile_name );
 printf( "������� ������ ������\n" );  
     if ( !yyparse() )  printf( "������ ������ �������\n" );
     else               printf( "�������. ������\n"       );
 EPS_end();                
 printf( "OK c EPS-������ %s,\n������� <Enter>", 
         EPSfile_name );
 getchar();
 return  0; 
 }
/*------------------------------------
 * ���������� yyparse � ������ ������ 
*------------------------------------*/
 yyerror( mes ) 
 char  *mes; 
 {  
 printf( "%s\n", mes ); 
 }
/** ����� ����� Lsystem.y. **********************************/  
