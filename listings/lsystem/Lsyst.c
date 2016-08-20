/*********************************************************
 * ���� Lsyst.c. ������� ������ ����� � ��������� L-system.
 * ������ ������� L-����, ������� � ������� "{" �� ������� "}" 
 * � ��������� ��� ����������� (�� ";" �� ����� ������). � 
 * ������ ������ ������������ ��������� Angle, Axiom � ������-
 * ��� ������, � ������� ����������� ����������� ������� Axiom
 * Order ���.
 *********************************************************/
 #include "Lsyst.h"
 #include <math.h> 
 const  double   pi = 3.14159265358979323846;       
/*------------------------------------
 * ��������� �� ������.
 *------------------------------------*/ 
 inline void  noOK( char  *message, char* str )
 {
 printf( "������: %s '%s'\n����� <Enter>\n", message, str );
 getchar();      
 }               
/*------------------------------------
 * ������ ������ ��. ����� � ���������� ����� Lsystem. ��� 
 * ����������� ������ ���������� 1, ����� 0. ����������
 * read_Lsyst.
 *------------------------------------*/ 
 static int  init_Lsystem( char  *str )
 {
 char  *Axiom              = "Axiom";
 char  *Angle              = "Angle";
 char  tmp_str[array_size] = ""; 
 int   right_str           = 1; /* ���� '������������' ���.  */  
      /* ����� � ������ str � ����������� ��������� Angle:   */
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
              noOK( "������������ ������ � ������", str ); 
              return  1;    
              }   
          }
      right_str = 0; 
      double  a = strtod( tmp_str, NULL );
          if   ( a )  initL.Angle = pi/a;
          else        initL.Angle = 0;
      }/* Angle �������� (���� �� ��������, ����� == 0). */
       /* ����� � ������ str � ����������� ������� Axiom: */
      if ( strstr( str, Axiom ) != NULL )
      {
      int  i = strlen( Axiom );  
           if  ( isalpha( str[i] ) )  
                 initL.Axiom = str[i];
           else  {
                 noOK( "������������ ������ � ������", str ); 
                 return  1;    
                 }
           while ( ++i <= strlen( str ) )
           {        
               if  ( iscntrl( str[i] ) ) 
                    continue;            
               else {
                    initL.Axiom = ' ';
                    noOK("������������ ������ � ������ ", str); 
                    return  1;    
                    }
           }  
      right_str = 0;       
      }/* Axiom �������� (���� �� ��������, ����� = ' '). */
      /* ����� � ������ str ��������� ������ ��������:     */
      if ( strstr( str, "=" ) && initL.Axiom != ' ' )
      {
          if ( initL.Axiom != str[0] || ( str[1]) != '=' ) 
          {
          noOK( "������������ ������ � ������ ", str ); 
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
          noOK( "������ ���������� ������ ", str ); 
          return  1;    
          }   
      right_str = 0;           
      }    
      if ( right_str && strlen( str ) > 1 ) 
      { 
      noOK( "������������ ������ �������� ", str ); 
      return  1;
      }
 return  0;     
 }    
/*------------------------------------
 * � ������ InitL.command ������ X ���������� �� InitL.command
 * Order ���. � ������ ������ ���������� 0, ����� -- 1. 
 *------------------------------------*/ 
 int  substitute( char  X, int  Order )
 {
 int   i                      = -1;
 char  command0[ array_size ] = "";   
     /* ��������� �������� ���������� ������ */
     /* ��������� � command0:                */
     while ( ++i <= strlen( initL.command ) ) 
     command0[i] = initL.command[i];  
     /* ������� ������� ��� ������ ������ X: */       
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
 * ������ ����� � ��������� L-system. ������ ������� ����,
 * ������� � ������� "{" �� ������� "}" � ��������� ���-
 * �������� (�� ";" �� ����� ������), ������� �����������. 
 * ��������� �� ����� "����������" ������ ���������� �� ���-
 * ��� init_Lsystem. ��� ����������� ������ ���������� 1, 
 * ����� 0.
 *------------------------------------*/         
 int  read_Lsyst( char  *file_name, int  Order )
 {
 initL.Angle                  = 0.0;    /* ��������    */
 initL.Axiom                  = ' ';    /* �� ����-    */ 
 initL.command[0]             = '\0';   /* �����       */     
 char   symb                  = ' ';
 char   curr_line[array_size] = "";
 FILE  *file; 
     if ( !( file = fopen( file_name, "r" ) ) )
     {
     noOK( "�� ���� ������� ������� L-���� ", file_name );            
     exit( 1 );
     }
     /* ���������� �� �� ���������� ������� '{'       */
     while ( ( symb != '{' ) && ( symb != EOF )  )
     symb = fgetc( file );
     if ( symb == EOF )
     {
     noOK( "��� ���������� ������� ", "'{'" );    
     return  1;
     } 
     else   /* ���������� ������:  '{'  */
     symb   = fgetc( file ); 
    /* ������ L-���� �� ������ �������, �������������� *
     * ������ ����� �� ������ ������� init_Lsystem:   */
     while ( symb != EOF )
     {
         switch ( symb )
         {
         case  ';' :  /* ���������� �����������  *
                       * �� ';' �� ����� ������: */
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
                      /* ��������� ������� ������������� *
                       * � ������  curr_line, �������    * 
                       * ������������:                   */
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
         noOK( "�� ������� ������ ", "'{'" );
         return  1;             
         }    
     } /*...while ( symb != EOF )... */ 
     if  ( fclose( file ) )
     {
     noOK( "���� ��� �������� L-����� ", file_name );
     abort();
     }
 return  0;          
 }  
/*------------------------------------
 * ��������� ����� ����� � ����� ������ v � ����.
 *------------------------------------*/          
 struct STACK* new_link( struct STACK      *ptr,  
                         struct CURR_DATA   v     )
 {
 stack *temp = (stack*) malloc( sizeof ( stack ) );
   if ( !temp )                                                        
   {
   printf( "�� ������� �������� ������!" );
   return  NULL;
   }
 temp->data = v;
 temp->link = ptr;
 return  temp;
 }  
/*------------------------------------
 * ���������� ����� �����, �� ������� ��������� ptr � ����-  
 * ������ ��������� � ��������� �����. 
 *------------------------------------*/
 struct STACK* delete_link( struct STACK *ptr )
 {
 stack  *temp = ptr;
 stack  *p    = ptr->link;
 free( temp );
 return  p;
 }   
/* ����� ����� Lsyst.c **************************************/
 
