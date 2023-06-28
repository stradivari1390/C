//Stas np 104
//The matrix MxN is given. Order it's columns so that their last elements formed decreasing sequence.
#include <stdio.h>
#define M 10
#define N 10
int main() {
  int mtrx[M][N],i,j,m,n,max=-999,temp[M][N];
  printf("\nThe matrix MxN is given\nOrder it's columns so that their last elements\nformed decreasing sequence.\n");
  printf("Enter matrix's dimension (M, then N):\n");
  scanf("%d%d",&m,&n);
  while((n<1&&n>10)||(m<1&&m>10)) {printf("Try again, remember: 0<M,N<11 and M,N-even.\n");
				   scanf("%d%d",&m,&n);}
  for(i=0;i<m;i++) for(j=0;j<n;j++) {printf("\nEnter a[%d][%d]: ",(i+1),(j+1));
				     scanf("%d",&mtrx[i][j]);}
  printf("\nHere we go:\n");
  for(i=0;i<m;i++) {for(j=0;j<n;j++) if(mtrx[i][j]<10) printf("%d  ",mtrx[i][j]);
				     else printf("%d ",mtrx[i][j]);
		    printf("\n");}
  for(j=0;j<n;j++) {if(mtrx[m-1][j]>max) {max=mtrx[m-1][j];for(i=0;i<m;i++) temp[i][1]=mtrx[i][j];
