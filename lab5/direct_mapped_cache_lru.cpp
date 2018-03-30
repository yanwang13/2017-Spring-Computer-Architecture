#include <iostream>
#include <fstream>
#include <stdio.h>
#include <math.h>

using namespace std;

struct cache_content{
	bool v;
	unsigned int  tag;
	int time;
//	unsigned int	data[16];
};

const int K=1024;
fstream fout;

double log2( double n )
{
    // log(n)/log(2) is log2.
    return log( n ) / log(double(2));
}

//void simulate(int cache_size, int block_size){
void simulate(int cache_size, int block_size, int set_size){ /*changed*/
	unsigned int tag,index,x;

	int offset_bit = (int) round(log2(block_size));
	//int index_bit = (int) log2(cache_size/block_size);
	int index_bit = (int) round(log2(cache_size/block_size/set_size)); /*changed*/
	int line= cache_size>>(offset_bit);
    int current_time = 0;
    double total = 0, miss = 0;

	cache_content *cache =new cache_content[line];
	//cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++)
    {
        cache[j].v=false;
        cache[j].time=0;
    }


  FILE * fp=fopen("LU.txt","r");					//read file

	while(fscanf(fp,"%x",&x)!=EOF){
		//cout<<hex<<x<<" ";
		bool hit = false;

		//index=(x>>offset_bit)&(line-1);
		index=((x>>offset_bit)&((line / set_size) - 1)) * set_size; /*changed*/
		tag=x>>(index_bit+offset_bit);

		current_time++;

		for(int i = 0; i < set_size; ++i)
        {
            if(cache[index + i].v && cache[index + i].tag==tag){
                cache[index + i].v=true; 			//hit
                cache[index + i].time=current_time;
                hit = true;
                break;
            }
        }

        if(!hit)
        {
            int replace_block = index;
            miss++;
            for(int i = 0; i < set_size; ++i) if(cache[index + i].time < cache[replace_block].time) replace_block = index + i;
            cache[replace_block].v = true;
            cache[replace_block].tag = tag;
            cache[replace_block].time = current_time;
        }
/*
		if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true; 			//hit
		}
		else{
			cache[index].v=true;			//miss
			cache[index].tag=tag;
			miss++;
		}
*/
		total++;

	}
	fout << "cache size: " << cache_size << endl;
	fout << "block size: " << block_size << endl;
	fout << "set size: " << set_size << endl;
	fout << "miss rate: " << miss / total  * 100 << '%' << endl;
	fout << endl;
	fclose(fp);

	delete [] cache;
}

int main(){
	// Let us simulate 4KB cache with 16B blocks
	int c_size[6] = {1, 2, 4, 8, 16, 32};
	int s_size[4] = {1, 2, 4, 8};

    fout.open("lu_result.txt", ios::out);

    for(int i = 0; i < 6; ++i) for(int k = 0; k < 4; ++k) simulate(c_size[i] * K, 64, s_size[k]);

	fout.close();

    return 0;
}
