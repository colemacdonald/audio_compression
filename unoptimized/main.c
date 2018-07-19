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

int pwlog2(int);

int inv_pwlog2(int);

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

int pwlog2(int x)
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

int inv_pwlog2(int y)
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
	int i;
	for (i = 0; i < len; i++)
	{
		int16_t x = src[i];
		int16_t sign = 1;

		if (x < 0)
		{
			x = -x;
			sign = -1;
		}

		dst[i] = sign * pwlog2(x);	
	}
}

void decompress_buffer(int16_t * src, int16_t * dst, int len)
{
	int i;
	for (i = 0; i < len; i++)
	{
		int16_t sign = 1;
		int16_t y = src[i];	
		if (y < 0)
		{
			y = -y;
			sign = -1;
		}

		dst[i] =  sign * inv_pwlog2(y);
	}
}
