import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[][] mmul(long[][] x, long[][] y)
{
    auto r = new long[][](x.length, y.length);
    foreach (i; 0..x.length) {
        foreach (j; 0..y[0].length) {
            foreach (k; 0..y.length) {
                r[i][j] = (r[i][j] + (x[i][k] * y[k][j]) % P) % P;
            }
        }
    }
    return r;
}

long[][] mpow(long[][] m, long k)
{
    auto r = new long[][](m.length, m[0].length);
    foreach (i; 0..m.length) {
        r[i][i] = 1;
    }
    while (k) {
        if (k%2 == 1) r = mmul(r, m);
        k /= 2;
        m = mmul(m, m);
    }
    return r;
}

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto A = new long[][](N, N);
    foreach (i; 0..N) {
        foreach (j, b; readln.split) {
            if (b == "1") A[i][j] = 1;
        }
    }
    auto m = mpow(A, K);
    long r;
    foreach (mm; m) foreach (e; mm) r = (r + e) % P;
    writeln(r);
}