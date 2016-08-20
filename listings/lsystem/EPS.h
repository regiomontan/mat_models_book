/*********************************************************
 * ���� EPS.h, ��������� ������� ��� ������ � EPS ������. 
 *********************************************************/
 struct  EPS
         {
         FILE*   file;
         char*   file_name;
         char*   discription;     
         int     maxX;          /* �������������            */
         int     maxY;          /* ����������               */
         int     minX;          /* ��������                 */
         int     minY;          /* �����������              */
         double  currX;         /* �������                  */ 
         double  currY;         /* ����������               */
         double  segment;       /* ����� ������� ��������� */
         } eps;  
/*------------------------------------
 * ������������ ����������� � ������ EPS-�����.
 *------------------------------------*/
 static void  EPS_head_comments();
/*------------------------------------
 * ������������ ����������� � ����� EPS-�����.
 *------------------------------------*/  
 static void  EPS_end_comment();
/*------------------------------------
 * ������������ "����" � ������� ����������.
 *------------------------------------*/
 void  EPS_movetoCurr(); 
/*------------------------------------
 * ������������ �� �������  ����� "����" �� ���������� segment
 * � ����������� initL.curr_Angle.
 *------------------------------------*/
 extern  void  EPS_moveto(); 
/*------------------------------------
 * ������ ������� ����� segment �� �������  ����� � ��������-
 * ��� initL.curr_Angle.
 *------------------------------------*/ 
 extern  void  EPS_lineto();
/*------------------------------------
 * ����������� ������� �������� ������ � ������ ��������.
 *------------------------------------*/  
 inline  void  min_max( double  x, double  y ); 
/*------------------------------------
 * ��������� EPS ���� name_file ��� ������, ����� � ���� ����-
 * ����� ���� ������������. �������������� ���� eps.
 *------------------------------------*/
 extern  void  EPS_begin( char* name_file );
/*------------------------------------
 * ���������� � ����� EPS ����� �������������� ���� ������-
 * ������, ��������� ����, ����� ��������� ��� ������ ��-
 * �������� ����� ������������ � ������ ��������� ��������. 
 *------------------------------------*/       
 extern  void  EPS_end();
/** ����� ����� EPS.h **************************************/ 

