/*
 * MAIN.C
 *
 * This file contains the program written for the SENG440 Project
 * written by Cole Macdonald and Noah Silvera
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


/******** ENUMS **********/
enum Comp { u1, u3, u7, u15, u31, u63, u127, u255 };

int u_vals[] =  { 1, 3, 7, 15, 31, 63, 127, 255 };

/************** PROTOTYPES ************/

int pwlog2(int);

int inv_pwlog2(int);

int ln(int);

int16_t decompress_u(enum Comp, int16_t);

int16_t compress_u(enum Comp, int16_t);

int convert_to_int(double);



void test_pwlog2()
{
}

/********** MAIN **********/
int main(void)
{
	/*
	// Read in test file
	FILE * fp = fopen("sample.wav", "rb");
	char * buffer;
		
	fseek(fp, 0, SEEK_END); 
	long filelen = ftell(fp);	
	rewind(fp);

	buffer = (char *)malloc((filelen+1)); 
	fread(buffer, filelen, 1, fp); 
	fclose(fp); 
	
	// ignore header
	char * data_start = buffer + 44;
	
	// don't need to store header
	int16_t * wav_data = (int16_t*)malloc(filelen + 1 - 44);
	int16_t * compressed_data = (int16_t*)malloc(filelen + 1 - 44);	

	// read data as int16
	int i;
	int w;
	for (i = 0, w = 0; i < filelen - 44; i+=2, w++)
	{
		wav_data[w] = (int16_t)(data_start[i] & 0xff) ;
		wav_data[w] |= (data_start[i+1] << 8);
	}

	for (i = 0; i < filelen/2; i++)
	{
		compressed_data[i] = compress_u(u15, wav_data[i]);
	}

	for (i = 0; i < 50; i++)
	{
		printf("%d, %d\n", wav_data[i], compressed_data[i]);
	}

	printf("\n");

	FILE* outfile = fopen("out.wav", "wb");

	fwrite(buffer, 1, 44, outfile);
	fwrite(

	free(wav_data);
	free(buffer);	
	*/

	int x0 = 40098;
	int y = compress_u(u15, x0);
	int x1 = decompress_u(u15, y);

	printf("%d --c->  %d --d-> %d\n", x0, y, x1);	

	int a = pwlog2(x0);
	int b = inv_pwlog2(a);

	printf("%d --log-> %d --invlog-> %d\n", x0, a, b);

	x1 = 280005;
	a = pwlog2(x1);
	b = inv_pwlog2(a);

	printf("%d --log-> %d --invlog-> %d\n", x1, a, b);
	return 0;
}

int convert_to_int(double x)
{
	return x * 32768.0;
}

int pwlog2(int x)
{
	if (x < (1 << 15))
		return -1; //error

	if (x < (1 << 16))
		return x - (1 << 15);

	if (x < (1 << 17))
		return (x >> 1);

	if (x < (1 << 18))
		return ((x >> 2) + (1 << 15));

	if (x < (1 << 19))
		return ((x >> 3) + (1 << 16));

	if (x < (1 << 20))
		return ((x >> 4) + (1 << 17));

	if (x < (1 << 21))
		return ((x >> 5) + (1 << 18));

	if (x < (1 << 22))
		return ((x >> 6) + (1 << 19));

	if (x < (1 << 23))
		return ((x >> 7) + (1 << 20));

	if (x < (1 << 24))
		return ((x >> 8) + (1 << 21));	

	return -1; // error
}

int inv_pwlog2(int y)
{
	if (y < (1 << 15))
		return y + (1 << 15);

	if (y < (1 << 16))
		return (y << 1);		

	if (y < ((1 << 15) + (1 << 16)))
		return ((y - (1 << 15)) << 2);

	if (y < (1 << 17)) 
		return ((y - (1 << 16)) << 3);
	
	if (y < ((1 << 16) + (1 << 17)))
		return ((y - (1 << 17)) << 4);

	if (y < ((1 << 16) + (1 << 18)))
		return ((y - (1 << 18)) << 5);

	if (y < ((1 << 16) + (1 << 19)))
		return ((y - (1 << 19)) << 6);

	if (y < ((1 << 16) + (1 << 20)))
		return ((y - (1 << 20)) << 7);

	if (y < ((1 << 16) + (1 << 21)))
		return ((y - (1 << 21)) << 8);

	return -1; // error
}

int ln(int x)
{
	return 0;
}


int16_t decompress_u(enum Comp u, int16_t Y)
{
	int16_t sign = 1;

	if (Y < 0)
	{
		sign = -1;
		Y = -Y;
	}

	return sign * (int)15 * (inv_pwlog2(Y) - 32768)/u_vals[u];
}

int16_t compress_u(enum Comp u, int16_t X)
{
	int16_t sign = 1;
	
	if (X < 0)
	{
		sign = -1;
		X = -X;
	}		
	
	return sign * (pwlog2((32768) + u_vals[u] * X)) / (int)(15);
}
