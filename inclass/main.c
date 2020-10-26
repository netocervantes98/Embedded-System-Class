
// Visual code with WSL Ubuntu 18.04 at windows 10
// Compilation line: gcc -o main  main.c -lrt
#include <stdio.h>
#include <signal.h>
#include <time.h>
#include <stdint.h>

#define NumTasks 4

timer_t firstTimerID;
void Task1(void);
void Task2(void);
void Task3(void);
void Task4(void);
static void SysTickHandler( int, siginfo_t*, void* );
static int makeTimer( timer_t*, int, int);

typedef struct {
    uint16_t Interval;
    uint32_t LastTick;
    void (*Func) (void);
} TaskType;

static TaskType Tasks[NumTasks] =
{
    { 20, 0, Task1 },
    { 40, 0, Task2 },
    { 120,0, Task3 },
    { 60,0, Task4 },
};

static TaskType* Task_ptr = Tasks;
int main()
{
    makeTimer(&firstTimerID, 2, 2); //generate a periodic interrupt every 2ms
    while(1)
        ;;
}
/* Service routine */
static void SysTickHandler( int sig, siginfo_t *si, void *uc )
{
    static uint32_t SysTickCounter = 0;
    static uint8_t TaskIndex = 0;

    printf("\n%d,\t\t%d", SysTickCounter, TaskIndex);
    for (TaskIndex = 0; TaskIndex < NumTasks; TaskIndex++) {
        if ((SysTickCounter - Task_ptr[TaskIndex].LastTick) >= Task_ptr[TaskIndex].Interval) {
            (*Task_ptr[TaskIndex].Func)();
            Task_ptr[TaskIndex].LastTick = SysTickCounter;
        }
    }

    SysTickCounter++;
}

static int makeTimer( timer_t *timerID, int expireMS, int intervalMS )
{
    struct sigevent te;
    struct itimerspec its;
    struct sigaction sa;
    int sigNo = SIGRTMIN;

    /* Set up signal handler. */
    sa.sa_flags = SA_SIGINFO;
    sa.sa_sigaction = SysTickHandler;
    sigemptyset(&sa.sa_mask);
    if (sigaction(sigNo, &sa, NULL) == -1) {
        perror("sigaction");
    }

    /* Set and enable alarm */
    te.sigev_notify = SIGEV_SIGNAL;
    te.sigev_signo = sigNo;
    te.sigev_value.sival_ptr = timerID;
    timer_create(CLOCK_REALTIME, &te, timerID);

    its.it_interval.tv_sec = 0;
    its.it_interval.tv_nsec = intervalMS * 1000000;
    its.it_value.tv_sec = 0;
    its.it_value.tv_nsec = expireMS * 1000000;
    timer_settime(*timerID, 0, &its, NULL);

    return 1;
}

void Task1(void) {
    printf("\nThis is Task 1");
}

void Task2(void) {
    printf("\nThis is Task 2");
}

void Task3(void) {
    printf("\nThis is Task 3");
}

void Task4(void) {
    printf("\nThis is Task 4");
}



