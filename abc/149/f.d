import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long P = 10^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

long inv(long x)
{
    return pow(x, P-2);
}

void main()
{
    auto N = readln.chomp.to!long;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }

    long[][] TT;
    TT.length = N;
    long run(int i, int p) {
        int s;
        foreach (j; T[i]) if (p != j) {
            auto n = run(j, i);
            TT[i] ~= n;
            s += n;
        }
        if (N-(s+1) > 0) TT[i] ~= N-(s+1);
        return s+1;
    }
    run(0, -1);

    long r, all = pow(2L, N);
    long all_h = all * inv(2) % P, iall = inv(all);
    foreach (i; 0..N) {
        if (TT[i].length == 1) continue;

        long rr = 1;
        foreach (n; TT[i]) {
            rr = (rr + (pow(2, n) - 1 + P) % P) % P;
        }
        r = (r + (all_h - rr + P) % P * iall % P) % P;
    }
    writeln(r);
}