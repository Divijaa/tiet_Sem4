#include<iostream>
using namespace std;

int main(){
	//n = number of processes
    int n=5;
    //m = number of resources
    int m=3;
    
    //total resources 
    int total[3]={10,5,7};
    int available[3]={3,3,2};
    
    // copy of available to make changes when the resources are released
    int work[3]={3,3,2};
    
	//chaiye kitne hai ek particular resource ko  
    int max[5][3] = { { 7, 5, 3 }, { 3, 2, 2 }, { 9, 0, 2 }, { 2, 2, 2 }, { 4, 3, 3 } }; // max matrix for P0,P1,P2,P3
     
    //already kitne given hai
    int alloc[5][3] = { { 0, 1, 0 }, { 2, 0, 0 },{ 3, 0, 2 },{ 2, 1, 1 },{ 0, 0, 2 } }; //allocation matrix for P0,P1,P2,P3
    
    //need = max-alloc
    int need[n][m];
	
	//step 1:
    for(int i=0;i<n;i++)
    {
        for(int j=0;j<m;j++)
        {
            need[i][j]=max[i][j]-alloc[i][j];
        }
    }
    
    bool finish[n]={0};
    int safeseq[n];

    int count =0;
    while(count<n){
    	
        bool found =false;
		//step 2:
        for(int i=0;i<n;i++)
		{
            if(finish[i]==false)
			{
                int a=0;
                
                while(a<m)
                {
                	//agr need jyada hai process ki toh ageh chlo
                    if(need[i][a]>work[a])
					{
                    break;
					}
                    a++;
                }
                //step : 3
                if(a==m)
				{
                    for(int k=0;k<m;k++)
					{
                        work[k]+=alloc[i][k];
                    }
                    //step 4:
                    finish[i]=1;
                    found=true;
                    safeseq[count]=i;
                    count++;
                }  
            }     
        }
        if (found == false)
        {
            cout<< "System is not in safe state";
            return 0;
        }
    }

    cout << "System is in safe state.\nSafe sequence is: ";
    for (int i = 0; i < n ; i++)
        cout <<"P"<<safeseq[i]<< " ";

    return 0;

}
