#include <bits/stdc++.h>
using namespace std;
void swap(int x, int y){
	int temp=x;
	x=y;
	y=x;
}
void waitingTime(int wt[], int bt[], int at[], int n)
{
	wt[0]=0;
	int sum=0;
	for(int i=0; i<n; i++){
		sum+=bt[i-1];
		wt[i]=sum-at[i];
		if(wt[i]<0) wt[i]=0;
	}
}
void turnaroundTime(int tat[], int bt[], int wt[], int n)
{
	for(int i=0; i<n; i++)
	tat[i]= bt[i]+wt[i];
}
int main(){
	int i,j,k=1,n=4;
	int p[]={1,2,3,4};
    int bt[n]={4,3,6,5};
    int at[n]={2,3,3,5};
	int wt[n],tat[n];
	double wtsum=0,tatsum=0;
	//for sorting according to the arrival time for finding shortest job first
	for(i=0; i<n-1; i++)
	{
		for(j=i+1; j<n; j++)
		{
			if(bt[i]>bt[j])
			{
				swap(at[i],at[j]);
				swap(bt[i],bt[j]);
				swap(p[i], p[j]);
			}	
		}
	}
		cout<<p[0]<<p[1]<<p[2]<<p[3];
	for(i=0; i<n; i++){
		int b=0;
		b+=bt[i];
		int min=bt[k];
		for(j=k; j<n; j++){
			if(b>at[i] && bt[i]<min){
				swap(p[j],p[k]);
				swap(at[j],at[k]);
				swap(bt[j],bt[k]);
			}
		}
		k++;
	
	}
	waitingTime(wt,bt,at,n);
	for(i=0; i<n; i++)
	wtsum+=wt[i];
	
	turnaroundTime(tat,bt,wt,n);
	for(i=0; i<n; i++)
	tatsum+=tat[i];
	
	for(i=0; i<n; i++)
	{
		cout<<endl<<i+1<<". Process p"<<p[i]<<endl;
		cout<<"waiting time "<<wt[i];
		cout<<"\nturn around time "<<tat[i]<<endl;
	}
	
	cout<<"\nAverage waiting time "<<wtsum/n;
	cout<<"\nAverage turn around time "<<tatsum/n;
	return 0;
}

