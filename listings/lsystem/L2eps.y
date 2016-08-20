 /*********************************************************
  * Файл Lsystem.y. 
  * Грамматика и соответствующие действия для трансляции с
  * языка L-систем на EPS. После обработки Bison'ом сгенериру-
  * ется головной файл программы. 
  *********************************************************/ 
 %{
  #include   <stdio.h>
  #include   <ctype.h>
  #include   "Lsyst.h"
  #include   "EPS.h"
  
  int     numb_symb = -1;    /* № символа в комм. строке */
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
 * Лексический анализатор 
 *------------------------------------*/
 yylex() 
 {
 ++numb_symb;        
 int c = initL.command[ numb_symb ];
    /* текущие значения координат и угла толкаем в стек: */ 
     if ( initL.command[ numb_symb ] == '[' )
     {
     struct  CURR_DATA  curr_data;	
     curr_data.x    = eps.currX;
     curr_data.y    = eps.currY;
     curr_data.ugol = initL.curr_Angle;
     top_stack = new_link( top_stack, curr_data ); 
     }
    /* значения координат и угла выталкиваем из стека    *
     * и делаем их текущими:                             */ 
     if ( initL.command[ numb_symb ] == ']')
     {
     eps.currX        = top_stack->data.x;
     eps.currY        = top_stack->data.y;
     EPS_movetoCurr();
     initL.curr_Angle = top_stack->data.ugol;	
     top_stack        = delete_link( top_stack );       	
     }	
     if ( numb_symb == strlen( initL.command ) ) 
     return  0;     /* дошли до конца --- успешный разбор */
     else                                       
     return  c; 
 }
/*------------------------------------*/
 int main ( int argc, char* argv[] )
 {
     if ( argc < 4 )
     {
     printf( "неверные аргументы, нужно:\n" );
     printf( "L2eps.exe имя_L-файла.l имя_EPS-файла.eps " );
     printf( "Order Angle0\n" );
     printf( "прессуй <Enter>");	
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
     printf( "\ncчитан файл %s\n",  Lfile_name       );
     printf( "Order   = %d\n",      Order            ); 
     printf( "Angle0  = %f\n",      initL.curr_Angle );
     printf( "Angle   = %f\n",      initL.Angle      );
     printf( "Axiom   = '%c'\n",    initL.Axiom      );
     printf( "command = '%s'\n",    initL.command    );
        if ( !substitute( initL.Axiom, Order ) )
        {
        printf("подстановка %d раз(а)\n", Order         ); 
        printf("command = '%s'\n",        initL.command );
        }
        else
        {
        printf( "сбой при подстановке в ком. строке" );
        exit( 1 );
        }
     }
     else
     {
     printf( "сбой при чтении файла %s\n", Lfile_name );	
     exit( 1 );
     } 	
 printf( "начинаю запись EPS файла\n" );    
 EPS_begin( EPSfile_name );
 printf( "начинаю разбор команд\n" );  
     if ( !yyparse() )  printf( "разбор прошёл успешно\n" );
     else               printf( "синтакс. ошибка\n"       );
 EPS_end();                
 printf( "OK c EPS-файлом %s,\nпрессуй <Enter>", 
         EPSfile_name );
 getchar();
 return  0; 
 }
/*------------------------------------
 * вызывается yyparse в случае ошибки 
*------------------------------------*/
 yyerror( mes ) 
 char  *mes; 
 {  
 printf( "%s\n", mes ); 
 }
/** конец файла Lsystem.y. **********************************/  
