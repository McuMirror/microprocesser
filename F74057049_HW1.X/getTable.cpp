#include <stdio.h>
#include <math.h>

int degree_to_distance(int d){
	return (int)(256*sin((double)d * M_PI / 180) + 0.5);
}

void get_table(){
	for(int i = 0; i <= 90; ++i){
		int ans = degree_to_distance(i); 
		if(ans == 256)
			ans--;
		printf("\tretlw\t0x%-4x\t; %d\n", ans, ans);
		//printf("\tsin(%d) = %f\n", i, sin((double)i * M_PI / 180));
	}
}

int main(){
	get_table();
	return 0;
}
