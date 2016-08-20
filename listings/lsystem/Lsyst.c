/*********************************************************
 * Файл Lsyst.c. Функции чтения файла с описанием L-system.
 * Читают входной L-файл, начиная с символа "{" до символа "}" 
 * и пропуская все комментарии (от ";" до конца строки). В 
 * случае успеха определяются параметры Angle, Axiom и команд-
 * ная строка, в которой произвоится подстановка символа Axiom
 * Order раз.
 *********************************************************/
 #include "Lsyst.h"
 #include <math.h> 
 const  double   pi = 3.14159265358979323846;       
/*------------------------------------
 * Сообщение об ошибке.
 *------------------------------------*/ 
 inline void  noOK( char  *message, char* str )
 {
 printf( "ОШИБКА: %s '%s'\nпресс <Enter>\n", message, str );
 getchar();      
 }               
/*------------------------------------
 * Анализ строки вх. файла и заполнение полей Lsystem. При 
 * обнаружении ошибки возвращает 1, иначе 0. Вызывается
 * read_Lsyst.
 *------------------------------------*/ 
 static int  init_Lsystem( char  *str )
 {
 char  *Axiom              = "Axiom";
 char  *Angle              = "Angle";
 char  tmp_str[array_size] = ""; 
 int   right_str           = 1; /* флаг 'неправильной' стр.  */  
      /* поиск в строке str и определение параметра Angle:   */
      if ( strstr( str, Angle ) != NULL )
      {
      int  i = strlen( Angle ) - 1;
      tmp_str[0] = '\0';
          while ( ++i <= strlen( str ) )
          {
          if (  iscntrl( str[i] ) )
          continue;
              if  ( isdigit( str[i] ) || str[i] == '.' )
              sprintf( tmp_str, "%s%c", tmp_str, str[i] ); 
              else   
              {
              noOK( "недопустимый символ в строке", str ); 
              return  1;    
              }   
          }
      right_str = 0; 
      double  a = strtod( tmp_str, NULL );
          if   ( a )  initL.Angle = pi/a;
          else        initL.Angle = 0;
      }/* Angle определён (если он правилен, иначе == 0). */
       /* поиск в строке str и определение символа Axiom: */
      if ( strstr( str, Axiom ) != NULL )
      {
      int  i = strlen( Axiom );  
           if  ( isalpha( str[i] ) )  
                 initL.Axiom = str[i];
           else  {
                 noOK( "недопустимый символ в строке", str ); 
                 return  1;    
                 }
           while ( ++i <= strlen( str ) )
           {        
               if  ( iscntrl( str[i] ) ) 
                    continue;            
               else {
                    initL.Axiom = ' ';
                    noOK("недопустимый символ в строке ", str); 
                    return  1;    
                    }
           }  
      right_str = 0;       
      }/* Axiom определён (если он правилен, иначе = ' '). */
      /* поиск в строке str командной строки символов:     */
      if ( strstr( str, "=" ) && initL.Axiom != ' ' )
      {
          if ( initL.Axiom != str[0] || ( str[1]) != '=' ) 
          {
          noOK( "недопустимый символ в строке ", str ); 
          return  1;    
          }
          else
          {
          int j = 1;
              while( ++j <= strlen( str ) )
              {
                   if ( !iscntrl( str[j] ) )   
                   sprintf( initL.command, "%s%c", 
                            initL.command, str[j]  );
              }  
          }
          if ( strlen( initL.command ) < 1 )
          {
          noOK( "пустая коммандная строка ", str ); 
          return  1;    
          }   
      right_str = 0;           
      }    
      if ( right_str && strlen( str ) > 1 ) 
      { 
      noOK( "недопустимая строка символов ", str ); 
      return  1;
      }
 return  0;     
 }    
/*------------------------------------
 * В строке InitL.command символ X заменяется на InitL.command
 * Order раз. В случае успеха возвращает 0, иначе -- 1. 
 *------------------------------------*/ 
 int  substitute( char  X, int  Order )
 {
 int   i                      = -1;
 char  command0[ array_size ] = "";   
     /* начальное значение коммандной строки */
     /* сохраняем в command0:                */
     while ( ++i <= strlen( initL.command ) ) 
     command0[i] = initL.command[i];  
     /* вставка символа или строки вместо X: */       
     while ( --Order > 0 )
     { 
     int  i = -1;
     char  tmp_str[ array_size ] = "";
         while ( ++i <= strlen( initL.command ) )
         {
         char  symb = initL.command[i];
             if  ( symb == X )
             {  
                 if  ( strlen(tmp_str) + strlen(initL.command)
                       > array_size )
                 return  1;  
             sprintf( tmp_str, "%s%s", tmp_str, command0 ); 
             }
             else   
             {    
                  if ( strlen( tmp_str ) + 1 > array_size )
                  return  1; 
             sprintf( tmp_str, "%s%c", tmp_str, symb ); 
             }
         } /* ...while ( ++i <= strlen( str ) )...*/
      int  j = -1;        
         while( ++j <= strlen( tmp_str ) )
         initL.command[j] = tmp_str[j];  
      } /* ...while ( --Order >= 0 )... */      
 return  0;              
 } 
/*------------------------------------
 * Чтение файла с описанием L-system. Читает входной файл,
 * начиная с символа "{" до символа "}" и пропуская ком-
 * ментарии (от ";" до конца строки), пробелы подавляются. 
 * Считанные из файла "правильные" строки передаются на ана-
 * лиз init_Lsystem. При обнаружении ошибки возвращает 1, 
 * иначе 0.
 *------------------------------------*/         
 int  read_Lsyst( char  *file_name, int  Order )
 {
 initL.Angle                  = 0.0;    /* значения    */
 initL.Axiom                  = ' ';    /* по умол-    */ 
 initL.command[0]             = '\0';   /* чанию       */     
 char   symb                  = ' ';
 char   curr_line[array_size] = "";
 FILE  *file; 
     if ( !( file = fopen( file_name, "r" ) ) )
     {
     noOK( "Не могу открыть входной L-файл ", file_name );            
     exit( 1 );
     }
     /* пропустить всё до начального символа '{'       */
     while ( ( symb != '{' ) && ( symb != EOF )  )
     symb = fgetc( file );
     if ( symb == EOF )
     {
     noOK( "Нет начального символа ", "'{'" );    
     return  1;
     } 
     else   /* обнаружено начало:  '{'  */
     symb   = fgetc( file ); 
    /* читаем L-файл по одному символу, сформированные *
     * строки отдаём на анализ функции init_Lsystem:   */
     while ( symb != EOF )
     {
         switch ( symb )
         {
         case  ';' :  /* пропустить комментарии  *
                       * от ';' до конца строки: */
                       {
                           while ( symb != '\n' )
                           symb = fgetc( file ); 
                       ungetc( symb, file );    
                       break;
                       }  
         case  '{' :   {
                       noOK( "'{...{'", " " ); 
                       return  1;     
                       }   
         case  '}' :   return  0;
         case  '\n':   {
                           if ( strlen( curr_line ) > 0 )
                           {
                              if (init_Lsystem(curr_line) == 1)
                              return  1; 
                           }
                       curr_line[0] = '\0';    
                       break;
                       }
                      /* считанные символы накапливаются *
                       * в строке  curr_line, пробелы    * 
                       * пропускаются:                   */
         default   :   {
                           if ( symb != ' ' )
                           sprintf( curr_line, "%s%c", 
                                    curr_line, symb    );
                       break;
                       }         
         }  /*...switch ( symb )... */
     symb = fgetc( file );
         if ( symb == EOF )
         {
         noOK( "не закрыта скобка ", "'{'" );
         return  1;             
         }    
     } /*...while ( symb != EOF )... */ 
     if  ( fclose( file ) )
     {
     noOK( "сбой при закрытии L-файла ", file_name );
     abort();
     }
 return  0;          
 }  
/*------------------------------------
 * Добавляет новое звено с полем данных v в стек.
 *------------------------------------*/          
 struct STACK* new_link( struct STACK      *ptr,  
                         struct CURR_DATA   v     )
 {
 stack *temp = (stack*) malloc( sizeof ( stack ) );
   if ( !temp )                                                        
   {
   printf( "не удалось выделить память!" );
   return  NULL;
   }
 temp->data = v;
 temp->link = ptr;
 return  temp;
 }  
/*------------------------------------
 * Уничтожает звено стека, на которое указывает ptr и прод-  
 * вигает указатель к основанию стека. 
 *------------------------------------*/
 struct STACK* delete_link( struct STACK *ptr )
 {
 stack  *temp = ptr;
 stack  *p    = ptr->link;
 free( temp );
 return  p;
 }   
/* конец файла Lsyst.c **************************************/
 
