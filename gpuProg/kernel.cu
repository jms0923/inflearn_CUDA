#include "kernel.cuh"

double getValue(int M, int N, int x_row, int y_col, double* List)
{
	int Ind = x_row * N + y_col;
	return List[Ind];
}

int getRowInd(int M, int N, int Ind)
{
	return (int)(Ind / N);
}

int getColInd(int M, int N, int Ind)
{
	return (int)(Ind % N);
}

void getMulti(int M, int N, int K, int ind, double* A, double* B, double* C)
{
	C[ind] = 0.;

	// C -> M * K
	int x_row = getRowInd(M, K, ind);

	int y_col = getColInd(M, K, ind);

	for (int i = 0; i < N; i++)
	{
		double a = getValue(M, N, x_row, i, A);
		double b = getValue(N, K, i, y_col, B);

		C[ind] += a * b;
	}
}

void Kernel(int M, int N, int K, double* A, double* B, double* C)
{
	for (int ind = 0; ind < M*N; ind++)
	{
		getMulti(M, N, K, ind, A, B, C);
	}
}