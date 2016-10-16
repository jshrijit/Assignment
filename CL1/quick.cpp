#include <iostream>
#include <pthread.h>
#include <stdlib.h>
#include <sched.h>
using namespace std;


int N;
struct args
{
	int *a;
	int first,last;
};
class QuickSort
{
public:
	void swap(int &a,int &b);
	void print(int a[],const int &N);
	int pivot(int a[],int first,int last);
};


void QuickSort::swap(int &a,int &b)
{
	int temp=a;
	a=b;
	b=temp;
}


void QuickSort::print(int a[],const int &N)
{
	for(int i=0;i<N;i++)
		cout<<"array ["<<i<<"] : "<<a[i]<<"\n";
}


int QuickSort::pivot(int a[],int first,int last)
{
	int p=first;
	int pivotElement=a[first];
	for(int i=first+1;i<=last;i++)
	{
		if(a[i]<=pivotElement)
		{
			p++;
			swap(a[i],a[p]);
		}
	}
	swap(a[p],a[first]);
	return p;
}


void* quickSort(void *arg)
{
	pthread_t id=pthread_self();

	args* ar=(args*)arg;
	QuickSort Q;
	int pivotElement;
	pthread_t threads[2];

	if(ar->first < ar->last)
	{
		pivotElement=Q.pivot(ar->a,ar->first,ar->last);
		cout<<"\nThe thread "<<id<<" is running on core "<<sched_getcpu()<<" found pivot element "<<ar->a[pivotElement]<<"\n";

		args array1;
		array1.a=new int[N];
		array1.a=ar->a;
		array1.first=ar->first;
		array1.last=pivotElement-1;
		args *x=&array1;
		int rc=pthread_create(&threads[0],NULL,&quickSort,(void*)x);

		args array2;
		array2.a=new int[N];
		array2.a=ar->a;
		array2.first=pivotElement+1;
		array2.last=ar->last;
		args *y=&array2;
		int rc1=pthread_create(&threads[1],NULL,&quickSort,(void*)y);

		pthread_join(threads[0],NULL);
		pthread_join(threads[1],NULL);
	}
}


int main()
{
	QuickSort Q1;
	int N;
	cout<<"\nEnter size of array: ";
	cin>>N;

	int test[N];
	cout<<"\nEnter elements of array: ";
	for(int i=0;i<N;i++)
		cin>>test[i];

	cout<<"\nBefore Sorting: "<<endl;
	Q1.print(test,N);

	args array;
	array.a=new int[N];
	array.a=test;
	array.first=0;
	array.last=N-1;
	quickSort(&array);

	cout<<"\nAfter sorting: "<<endl;
	Q1.print(test,N);
	return 0;
}

