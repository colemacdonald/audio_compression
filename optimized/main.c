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
#include <time.h>

/******** CONSTANT **********/
int header_size = 66;

/************** PROTOTYPES ************/

inline int pwlog2(int);
inline int inv_pwlog2(int);

void compress_buffer(int16_t *, int16_t *, int);
void decompress_buffer(int16_t *, int16_t *, int);

/********** MAIN **********/
int main(int argc, char** argv)
{
	// Read in test file
	FILE * fp = fopen("../africa-toto.wav", "rb");
	
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
	compress_buffer(wav_data, compressed_data, (filelen - header_size)/2);
	
	// decompress
	decompress_buffer(compressed_data, decompressed_data, (filelen - header_size)/2);	

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

	return 0;
}

inline int pwlog2(int x)
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

inline int inv_pwlog2(int y)
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


void compress_buffer(int16_t * src, int16_t * dst, int len)
{
	int i = len - 1;

	// loop unrolling case
	if (!(len%2))
	{
		int16_t x = src[i];
		int sign = 0;

		if (x & 0x8000)
		{
			x = -x;
			++sign;
		}

		if (sign)
			dst[i] = -pwlog2(x);
		else
			dst[i] = pwlog2(x);	

		--i;
	}

	// optimize for loop conditions
	for (; i; i-=2)
	{
		// unroll loop once, paralize to reduce data dependencies
		int16_t x1 = src[i];
		int16_t x2 = src[i - 1];

		int sign1 = 0;
		int sign2 = 0;

		// check sign bit (two's complement signed integer)
		if (x1 & 0x8000)
		{
			x1 = -x1;
			++sign1;
		}
		
		if (x2 & 0x8000)
		{
			x2 = -x2;
			++sign2;
		}

		if (sign1)
			dst[i] = -pwlog2(x1);		
		else
			dst[i] = pwlog2(x1);

		if (sign2)
			dst[i - 1] = -pwlog2(x2);
		else
			dst[i - 1] = pwlog2(x2);
	}
	// handle i = 0
	int16_t x = src[0];
	int sign = 0;

	if (x & 0x8000)
	{
		x = -x;
		++sign;
	}

	if (sign)
		dst[0] = -pwlog2(x);
	else
		dst[0] = pwlog2(x);	
}

void decompress_buffer(int16_t * src, int16_t * dst, int len)
{
	int i = len - 1;

	if (!(len%2))
	{
		int16_t y = src[0];
		int sign = 0;

		if (y & 0x8000)
		{
			y = -y;
			++sign;
		}

		if (sign)
			dst[0] = -inv_pwlog2(y);
		else
			dst[0] = inv_pwlog2(y);
		--i;
	}
	for (; i; i-=2)
	{
		int sign1 = 0;
		int sign2 = 0;
		
		int16_t y1 = src[i];	
		int16_t y2 = src[i - 1];

		if (y1 & 0x8000)
		{
			y1 = -y1;
			++sign1;
		}

		if (y2 & 0x8000)
		{
			y2 = y2;
			++sign2;
		}

		dst[i] = inv_pwlog2(y1);
		dst[i - 1] = inv_pwlog2(y2);

		if (sign1)
			dst[i] = -dst[i];

		if (sign2)
			dst[i - 1] = -dst[i - 1];
	}
	// handle i = 0
	int16_t y = src[0];
	int sign = 0;

	if (y & 0x8000)
	{
		y = -y;
		++sign;
	}

	if (sign)
		dst[0] = -inv_pwlog2(y);
	else
		dst[0] = inv_pwlog2(y);
}
