//----------------------------------------------------------------------------------------------    
#include <iostream> 
typedef unsigned int WORD ; 

using namespace std ; 

const MaxN = 101 ; 

struct List { 
   List (){} ; 
   List ( int _V , List * _next ) { V = _V ; next =  _next ;} 
   List * next  ; 
   int V ; 
}; 

int    e[MaxN];            // ����⮪ 
int    h[MaxN];            // ���� ���設� 
int    f[MaxN][MaxN];         // ����饥 ���祭�� �।��⮪� 
int    c[MaxN][MaxN];         // �ய�᪭� ᯮᮡ���� ॡ�� 

//List L ;               // �� ��୨�� V[G]\{s,t} 
//List N[MaxN] ;            // ᯨ᮪ �吝���     
List *head[MaxN] , *current[MaxN] , *headL , *pre; 

int  n , m , s = 1,  t , minH ;      // s -  ��⮪ , t- �⮪ 

//----------------------------------------------------------------------------------------------    
 void ConstructL(){            // � ᯨ᪥ L  �࠭���� �� ���設� �஬� s,t 
               // �.� V[G]\{s,t} 
      List *cur  ; 
      List * t = new List (2 , NULL ); 
      pre = headL = t ; cur = t ; 
      for (int i = 3 ; i < n ; i++ ) 
      { 
         List *t  = new List ( i , NULL) ; 
         cur->next = t ; 
         cur = cur->next ; 
      } 
 } 
//----------------------------------------------------------------------------------------------    
 int min (int a , int b ){ 
    return a<b ? a:b ; 
 } 
//----------------------------------------------------------------------------------------------                                       // ��६�頥� ���設� � ��砫� 
 void MoveToFront ( List *u ) { 
    
   if ( pre == u )return ; 

   pre->next = u->next ; 

   List * t = new List (u->V , headL ) ; 
   pre = headL = t ; 

   delete u ;       
 } 
//----------------------------------------------------------------------------------------------    
               // ���樠�����㥬 �।��⮪ 
 void Initilize_PreFlow () {    
               // ����� ������ ��� ����⭮ 
    h[s] = n ; 
    for (int u = 1 ; u <= n ; u++ ){ 
       if ( c[s][u] > 0 ){ 
          f[s][u] =  c[s][u] ; 
          f[u][s] = -c[s][u] ; 
          e[u] = c[s][u]; 
       } 
    } 
 } 
//----------------------------------------------------------------------------------------------                               
               // ��⠫������ ��⮪ �.� � ���設� u ���� ����⮪ 
 void Push (int u , int v ){         // � ��� ���� ��⮫����� ��⮪ ����� 

    int d = min (e[u] , c[u][v]-f[u][v]); 
    
    f[u][v] =  f[u][v] + d ;        // 㢥��稢��� ��⮪ �� ॡ�� (u,v) 
    f[v][u] = -f[u][v] ; 

    e[u] = e[u] - d ;             
    e[v] = e[v] + d ; 
 } 
 //----------------------------------------------------------------------------------------------    
                 //  ��������� ���設� �⮡ ��⮫���� ��⮪ 
 void Lift ( int u ) {              //  �.� ��⠫������ ����� ⮫쪮 �� ��設 ����襩 ����� 
    minH = 100000 ; 
   List *v = head[u];           //��ᬠ�ਢ��� �� ���設� � ����筮� �� � ��������� ����� 
   while (v){              // ⠪ �⮡ ��� �⠫� �� 1 ��� ᠬ�� ������ 
      if (minH > h[v->V] && c[u][v->V]-f[u][v->V] > 0 )minH = h[v->V]; 
      v =  v->next ; 
   } 
   h[u] = ( minH +1 ) ; 
 } 
//----------------------------------------------------------------------------------------------    
 void Discharge ( int u ){         // ࠧ��㧪� ���設� 
    while ( e[u] > 0 ){         // ���� ���� ����⮪        
       List* v = current[u]; 
       if ( current[u] == NULL ){ 
          Lift ( u );            // ��������� ���設� 
          current[u] = head[u]; 
       }                                                                   
       else if ( c[u][v->V]-f[u][v->V] > 0 && h[u] == h[v->V] + 1) 
          Push (u , v->V );      // ��諨 �����⨬�� ॡ� � ��⮫��㫨 ��⮪ 
       else current[u] = current[u]->next ;   // ���室�� � ᫥���饬� �������� 
    } 
 } 
//----------------------------------------------------------------------------------------------    
 void Lift_To_Front (){ 

   Initilize_PreFlow() ;          // ��ନ�㥬 ��砫�� �।��⮪ 
   ConstructL() ; 

   for (int i = 2 ; i < n ; i++ )       // s == 1 , t == n 
      current[i] = head[i]; 

   List *u = headL ; 

   while ( u != NULL ){                
      int old_height  = h[u->V]; 

      Discharge( u->V );       // �����㦠�� ���設� u 

      if ( h[u->V] > old_height ){    // �᫨ ���設� �뫮 ������ � 
         MoveToFront ( u );   // ��६�頥� �� � ��砫� ᯨ᪠ 
         u = headL; 
      } 
      pre = u ; 
      u = u->next ;       // ���室�� � ᫥���饩 ���設� 
   } 
   // �� ��室� �� ��楤��� �� ��ꥪ�� ᮧ���� ������ new ���� 
   // 㤠���� �� �� ����������� , ��� ���� ��⠢��� �� ��� :) 
 } 
//------------------------------------------------------------------------------------------------ 
 int main () { 
    
   cin >> n >> m ;         // ����� n - ������⢮ ���設 m - ������⢮ ��� 
   int a , b , cf ;         // ..�ய�᪭�� ᯮᮡ����� ॡ� (a,b) == cf 
   for (int i = 0 ; i < m ; i++ ) 
   { 
       cin >> a >> b >> cf ; 
       c[a][b] = cf; 
   } 
               //.. ��� ������ ���設� u � V ��ந� ������஭�� ᯨ᮪ 
    for (int i = 1 ; i <= n ; i++ ){        // �ᥤ�� ���設� v ��室���� � �⮬ ᯨ᪥ ��� 
       List *cur ;      // (u,v) � E ��� (v,u) � E 
       int w = 0 ; 
       for (int j = 1 ; j <= n ; j ++ ){ 
          if ( c[i][j] > 0 || c[j][i] > 0 ){ 
            List * t = new List( j , NULL ) ; 
            if (!w){ 
               head[i] = t ; 
               cur = t ; 
               w = 1 ; 
            } 
            else { 
               cur->next = t ; 
               cur = cur->next ; 
            } 
          }                    
       } 
    } 

Lift_To_Front (); 
               // � ��ᨢ� f ����� ��⮪ 
int sum = 0 ; 
for (int i = 1 ; i <= n ; i++ ) 
   sum +=  f[i][n]; 

   cout << sum ; 
    return 0 ; 
 } 
 //------------------------------------------------------------------------------------------------