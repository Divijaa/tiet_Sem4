#include <iostream>
using namespace std;
void waitingTime(int bt[], int wt[], int at[], int n){
	int i, st[n];
	st[0]=at[0];
	wt[0]=0;
	//service time
	for(i=1; i<n; i++){
		st[i]=st[i-1]+bt[i-1];
		//waiting time for current process
		wt[i]=st[i]-at[i];
		if(wt[i]<0) wt[i]=0;
	}
}
void turnAroundTime(int bt[], int wt[], int at[], int tat[], int n){
	for(int i=0; i<n; i++)
	tat[i]=bt[i]+wt[i];
}
int main(){
	int n=3;
	int bt[n]={5,1,2};
	int at[n]={0,1,2};
	int wt[n], tat[n];
float tot_wt=0, tot_tat=0;
	waitingTime(bt, wt, at, n);
	turnAroundTime(bt, wt, at, tat, n);
	for(int i=0; i<n; i++){
		cout<<endl<<"Process P"<<i+1<<endl;
		cout<<"Waiting Time: "<<wt[i]<<endl;
		cout<<"Turn Around Time: "<<tat[i]<<endl;
		tot_wt+=wt[i]; tot_tat+=tat[i];
	}
	cout<<"\nAverage Waiting Time: "<<tot_wt/n<<endl;
	cout<<"Average Turn Around Time: "<<tot_tat/n<<endl;
	return 0;
}

