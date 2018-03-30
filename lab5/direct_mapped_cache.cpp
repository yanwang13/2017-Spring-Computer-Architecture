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

void simulate(int cache_size, int block_size){
	unsigned int tag,index,x;

	int offset_bit = (int) round(log2(block_size));
	int index_bit = (int) round(log2(cache_size/block_size));
	int line= cache_size>>(offset_bit);
    double total = 0, miss = 0;

	cache_content *cache =new cache_content[line];
	//cout<<"cache line:"<<line<<endl;

	for(int j=0;j<line;j++)
        cache[j].v=false;


  FILE * fp=fopen("ICACHE.txt","r");					//read file

	while(fscanf(fp,"%x",&x)!=EOF){
		//cout<<hex<<x<<" ";

		index=(x>>offset_bit)&(line-1);
		tag=x>>(index_bit+offset_bit);

		if(cache[index].v && cache[index].tag==tag){
			cache[index].v=true; 			//hit
		}
		else{
			cache[index].v=true;			//miss
			cache[index].tag=tag;
			miss++;
		}

		total++;

	}
	fout << "cache size: " << cache_size << endl;
	fout << "block size: " << block_size << endl;
	fout << "miss rate: " << miss / total  * 100 << '%' << endl;
	fout << endl;
	fclose(fp);

	delete [] cache;
}

int main(){
	// Let us simulate 4KB cache with 16B blocks
	int c_size[4] = {4, 16, 64, 256};
	int b_size[5] = {16, 32, 64, 128, 256};

    fout.open("icache_result.txt", ios::out);

    for(int i = 0; i < 4; ++i) for(int j = 0; j < 5; ++j) simulate(c_size[i] * K, b_size[j]);

	fout.close();

    return 0;
}
