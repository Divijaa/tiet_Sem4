#include<stdio.h>
#include<conio.h>
void main()
{
	int count , i , n , time , remain , flag = 0 , qt;
	int wait_time = 0 , turn_a = 0 , arrival [10] , burst [10] , rem[10];
	
	n = 4;
	remain = n ;
	
	for(count = 0 ; count < n ; count++)
	{
		printf("enter arrival , burst \n");
		scanf("%d" , &arrival[count]);
		scanf("%d" , &burst[count]);
		rem[count] = burst[count];
	}
	
	qt = 2 ;
	time = 0;
	count = 0;
	while(remain != 0)
	{
		if(rem[count] == 0 && flag == 1)
		{
			remain --;
			wait_time += time- arrival[count] - burst[count];
			turn_a += time - arrival[count];
			printf("P[%d] \t %d \t %d \t \n" , count+1 ,wait_time , turn_a);
			
		}
		if(rem[count] < qt && rem[count] > 0)
		{
			time +=rem[count];
			rem[count] = 0;
			flag = 1;
		}
		else if(rem[count] > 0)
		{
			rem[count] -=qt;
			time += qt;
		}
		if(count == n-1)
			count = 0;
		else if(arrival [count +1] <= time)
			count++;
		else
			count = 0;
			
	}
	printf("\nAverage Waiting Time= %f\n",wait_time*1.0/n);
  	printf("Avg Turnaround Time = %f",turn_a*1.0/n);
  
  return 0;
}
