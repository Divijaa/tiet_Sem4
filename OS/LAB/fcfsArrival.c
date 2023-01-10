
#include <conio.h>
#include <stdio.h>

// computation of waiting time
void waitingTime(int p[], int n, int burst_time[], int arrival_time[])
{
    int waiting[10], cpu;
    float avt = 0;
    waiting[0] = 0;
    cpu = arrival_time[0];
    for (int i = 1; i < n; i++)
    {
        cpu += burst_time[i - 1];
        if (arrival_time[i] > cpu)
        {
            waiting[i] = arrival_time[i] - cpu;
        }
        else
        {
            waiting[i] = 0;
        }
    }

    for (int i = 0; i < n; i++)
    {
        avt = avt + waiting[i];
        printf("Waiting:%d", waiting[i]);
        printf(" ");
    }
    avt = avt / n;
    printf("\nAverage waiting time:%f", avt);
}

void completionTime(int p[], int n, int burst_time[], int arrival_time[])
{
    int completion[10];
    float avc = 0;
    completion[0] = burst_time[0] + arrival_time[0];
    for (int i = 1; i < n; i++)
    {
        if (completion[i - 1] < arrival_time[i])
        {
            completion[i] = burst_time[i] + arrival_time[i];
        }
        else
        {
            completion[i] = completion[i - 1] + burst_time[i];
        }
    }

    for (int i = 0; i < n; i++)
    {
        avc = avc + completion[i];
        printf("Completion:%d", completion[i]);
        printf(" ");
    }
    avc = avc / n;
    printf("\nAverage completion time:%f", avc);
}

void fcfs(int p[], int n, int burst_time[], int arrival_time[])
{

    waitingTime(p, n, burst_time, arrival_time);

    completionTime(p, n, burst_time, arrival_time);
}

int main()
{
    int p[] = {1, 2, 3, 4};
    int burst_time[] = {4,
                        2,
                        3,
                        1};

    int arrival_time[] = {2, 7, 8, 9};
    int n = 4;

    fcfs(p, n, burst_time, arrival_time);
}