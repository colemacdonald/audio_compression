/*
 * MAIN.C
 *
 * This file contains the program written for the SENGheader_size0 Project
 * written by Cole Macdonald and Noah Silvera
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>


/******** ENUMS **********/
enum Comp { u1, u3, u7, u15, u31, u63, u127, u255, u511, u1023 };

int u_vals[] =  { 1, 3, 7, 15, 31, 63, 127, 255, 511, 1023 };

int header_size = 66;
int compression_constant = u1023;

/************** PROTOTYPES ************/

int pwlog2(int);

int inv_pwlog2(int);

int16_t decompress_u(enum Comp, int16_t);

int16_t compress_u(enum Comp, int16_t);

int16_t compress(int16_t);
int16_t decompress(int16_t);

/********** MAIN **********/
int main(void)
{
	// Read in test file
	FILE * fp = fopen("sample.wav", "rb");
		
	fseek(fp, 0, SEEK_END); 
	long filelen = ftell(fp);	
	rewind(fp);

	// wav buffer
	char * buffer = (char *)malloc((filelen+1)); 
	fread(buffer, filelen, 1, fp); 
	fclose(fp); 
	
	// ignore header
	char * data_start = buffer + header_size;
	
	// allocate memory - don't need to store header
	int16_t * wav_data = (int16_t*)malloc(filelen + 1 - header_size);
	int16_t * compressed_data = (int16_t*)malloc(filelen + 1 - header_size);	
	int16_t * decompressed_data = (int16_t*)malloc(filelen + 1 - header_size);

	// read data as int16
	int i;
	int w;
	for (i = 0, w = 0; i < filelen - header_size; i+=2, w++)
	{
		wav_data[w] = (int16_t)(data_start[i] & 0xff) ;
		wav_data[w] |= (data_start[i+1] << 8);
	}

	// compress data
	for (i = 0; i < (filelen - header_size)/2; i++)
	{
//		compressed_data[i] = compress_u(compression_constant, wav_data[i]);
		compressed_data[i] = compress(wav_data[i]);
	}

	// print first 50
	for (i = 0; i < 50; i++)
	{
		printf("%d, %d\n", wav_data[i + 60], compressed_data[i + 60]);
	}
	printf("\n");

	// decompress
	for (i = 0; i < (filelen - header_size)/2; i++)
	{
//		decompressed_data[i] = decompress_u(compression_constant, compressed_data[i]);	
		decompressed_data[i] = decompress(compressed_data[i]);
	}

	// write to file
	FILE* outfile = fopen("out.wav", "wb");

	fwrite(buffer, 1, header_size, outfile);
	fwrite(decompressed_data, 2, (filelen - header_size)/2, outfile);

	// free memory
	free(decompressed_data);
	free(compressed_data);	
	free(wav_data);
	free(buffer);

	// close outfile
	fclose(outfile);

	int16_t asdf = compress(32000);
	printf("%d\n", 32000);
	printf("%d\n", asdf);
	printf("%d\n", decompress(asdf));
	

	return 0;
}

int f_pwlog2(int x)
{
	if (x < (1 << 4))
		return x;

	if (x < (1 << 8))
		return (x >> 1) + (1 << 3);
	
	if (x < (1 << 12))
		return (x >> 3) + (1 << 7);

	if (x < (1 << 16))
		return (x >> 6) + (1 << 9);

	return -1; // error
}

int inv_f_pwlog2(int y)
{
	if (y < (1 << 4))
		return y;

	if (y < (1 << 3) + (1 << 7))
		return (y - (1 << 3)) << 1;

	if (y < (1 << 7) + (1 << 9))
		return (y - (1 << 7)) << 3;

	if (y < (1 << 10))
		return (y - (1 << 9)) << 6;

	return -1; // error
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

	if (x < (1 << 25))
		return ((x >> 9) + (1 << 22));

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

	if (y < ((1 << 17) + (1 << 22)))
		return ((y - (1 << 22)) << 9);
	
	return -1; // error
}


int16_t decompress_u(enum Comp u, int16_t Y)
{
	int16_t sign = 1;

	if (Y < 0)
	{
		sign = -1;
		Y = -Y;
	}
	
	return sign * (inv_pwlog2(Y * u_vals[u]) - 32768) / u_vals[u];
	
}

int16_t compress(int16_t x)
{
	int16_t sign = 1;

	if (x < 0)
	{
		x = -x;
		sign = -1;
	}

	return sign * f_pwlog2(x);	
}

int16_t decompress(int16_t y)
{
	int16_t sign = 1;
	
	if (y < 0)
	{
		y = -y;
		sign = -1;
	}

	return sign * inv_f_pwlog2(y);
}

int16_t compress_u(enum Comp u, int16_t X)
{
	int16_t sign = 1;
	
	if (X < 0)
	{
		sign = -1;
		X = -X;
	}		
	
	return sign * (pwlog2((32768) + u_vals[u] * X)) / u_vals[u];
}
