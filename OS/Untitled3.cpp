#include<iostream>
using namespace std;
int main()
{
	int n = 4;
	int arrival[n]={2,7,8,9};
	int burst[n] ={4,2,3,1};
	int waiting[n];
	int tt[n];
	int comp[n];
	comp[0] = burst[0]+arrival[0];
	
	for(int i =  1; i < n ; i++)
	{
		comp[i] = burst[i]+comp[i-1];
		if(arrival[i] > comp[i-1])
		{
			comp[i]++;
		}
		//comp[i] = burst[i] +arrival[i];
		cout<<comp[i];  
	}
	for(int i = 0 ; i < n ;i++)
	{
		tt[i] = comp[i] - arrival[i];
		waiting[i] = tt[i]-burst[i];
		if(waiting[i] < 0) waiting[i] = 0;
	}
	float sum1 = 0;
	float sum2= 0;
	for(int i = 0 ; i< n ;i++)
	{
		cout<<"waiting time of P"<<i<<" is "<<waiting[i]<<endl;
		cout<<"turnaround time of p"<<i<<" is "<<tt[i]<<endl;
		cout<<endl;
		sum1+=waiting[i];
		sum2+=tt[i];
	}
	float avg_wait = sum1/n;
	cout<<avg_wait<<endl;
	float avg_tt = sum2/n;
	cout<<avg_tt;
}
