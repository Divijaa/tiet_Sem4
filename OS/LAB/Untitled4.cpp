#include<iostream>
using namespace std;
void wating_time(int burst[] , int wait[] , int arrival[] , int n)
{
    int i , completion[n];
    completion[0] = arrival[0];
    wait[0] = 0;
    
    for(i = 1 ; i < n ;i++)
    {
        completion[i] = completion[i-1] + burst[i-1];
        
        wait[i] = completion[i]-arrival[i];
        if(wait[i] < 0) wait[i] = 0;
    }
}

void turnAround_time(int burst[] , int wait[] , int arrival , int tat[] , int n)
{
    for(int i = 0 ; i < n ;i++)
    {
        tat[i]=burst[i]+wait[i];
    }
    
}
int main()
{
    int n = 4;
    int burst[n] = {4,3,6,5};
    int arrival[n] = {2,3,3,5};
    
    int wait[n], tat[n];
    
    float tot_wt=0, tot_tat=0;
    
	wating_time(burst, wait, arrival, n);
	turnAround_time(burst, wait, arrival, tat, n);
	
	for(int i=0; i<n; i++)
	{
		cout<<endl<<"Process P"<<i+1<<endl;
		cout<<"Waiting Time: "<<wait[i]<<endl;
		cout<<"Turn Around Time: "<<tat[i]<<endl;
		
		tot_wt+=wait[i]; 
		tot_tat+=tat[i];
	}
	cout<<"\nAverage Waiting Time: "<<tot_wt/n<<endl;
	cout<<"Average Turn Around Time: "<<tot_tat/n<<endl;
	return 0;
    
}
