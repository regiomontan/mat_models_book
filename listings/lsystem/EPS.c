/*********************************************************
 * Файл EPS.c, Функции для работы с EPS файлом. 
 *********************************************************/ 
 #include  <stdio.h> 
 #include  <math.h>
 #include  <limits.h>
 #include  "EPS.h"
 #include  "Lsyst.h"
/*------------------------------------
 * Заголовочные комментарии вначале EPS-файла.
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
 * Заголовочные комментарии в конце EPS-файла.
 *------------------------------------*/
 void  EPS_end_comment() 
 { 
 fprintf( eps.file, "stroke \n"         );
 fprintf( eps.file, "closepath \n"      );
 fprintf( eps.file, "%%%%Page: 1 1 \n" );
 fprintf( eps.file, "%%%%EOF \n"        );
 }
/*------------------------------------
 * передвижение "пера" в текущие координаты.
 *------------------------------------*/
 void  EPS_movetoCurr()
 {
 fprintf( eps.file, "%- 16.4f %- 16.4f     moveto \n",
          eps.currX, eps.currY ); 
 }
/*------------------------------------
 * передвижение от текущей  точки "пера" на расстояние segment
 * в направлении initL.curr_Angle.
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
 * Рисует отрезок длины segment от текущей  точки в направле-
 * нии initL.curr_Angle.
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
 * Определение крайних значений ширины и высоты картинки,
 * нужно для масштабирования.
 *------------------------------------*/  
 void  min_max( double  x, double  y )
 {
      if ( eps.minX > x )  eps.minX = x;
      if ( eps.maxX < x )  eps.maxX = x;
      if ( eps.minY > y )  eps.minY = y;
      if ( eps.maxY < y )  eps.maxY = y;                
 }        
/*------------------------------------
 * Открывает EPS файл name_file для записи, пишет в него нача-
 * льный блок комментариев. Инициализирует поля eps.
 *------------------------------------*/       
 void  EPS_begin( char* name_file )
 {
 eps.file_name   = name_file;
 eps.discription = "визуализация L-системы";
 eps.segment     = 100;         /* длина отрезка рисования   */
 eps.minX        = INT_MAX;     /* экстремальные             */
 eps.minY        = INT_MAX;     /* значения                  */
 eps.maxX        = INT_MIN;     /* размеров                  */
 eps.maxY        = INT_MIN;     /* картинки                  */
 eps.currX       = 0.0;         /* текущие значения          */ 
 eps.currY       = 0.0;         /* координат 'пера'          */
 min_max( eps.currX, eps.currY );
     if ( !( eps.file = fopen( eps.file_name, "w" ) ) )
     {
     printf( "не могу открыть файл %s", eps.file_name );            
     exit( 1 );
     }  
 EPS_head_comments(); 
 }     
/*------------------------------------
 * Записывает в конец EPS файла заключительный блок коммен-
 * тариев, закрывает файл, снова открывает для замены на-
 * чального блока комментариев с новыми размерами картинки. 
 *------------------------------------*/       
 void  EPS_end()
 { 
 EPS_end_comment(); 
     if  ( fclose( eps.file ) )
     {
     printf( "не могу закрыть файл %s ", eps.file_name );
     abort();
     }
     else
     {    
         /* перезаписываю начало файла (нужно для масш- */ 
         /* табирования картинки)                       */ 
         if ( !( eps.file = fopen( eps.file_name, "r+" ) ) )
         {
         printf( "не могу открыть файл %s ", eps.file_name );            
         exit( 1 );
         }  
         else  
         {
         eps.minX -= 5;   /* для красоты      */
         eps.maxX += 5;   /* чуть             */
         eps.minY -= 5;   /* увеличиваем      */ 
         eps.maxY += 5;   /* размеры картинки */                
         EPS_head_comments( eps ); 
             if  ( fclose( eps.file ) )
             {                 
             printf( "не могу закрыть файл %s", eps.file_name );
             abort();
             }  
         }
     }                    
 } 
/** конец файла EPS.c **************************************/ 

