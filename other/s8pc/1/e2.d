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

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    
    auto as = readln.split.to!(long[]);
    auto ds = new long[](N);
    foreach (i; 0..N-1) ds[i+1] = (ds[i] + pow(as[i], as[i+1])) % P;
    
    auto cs = [1] ~ readln.split.to!(int[]) ~ [1];
    long d;
    foreach (i; 0..Q+1) {
        auto x = cs[i]-1;
        auto y = cs[i+1]-1;
        if (x > y) swap(x, y);
        d = (d + (ds[y] - ds[x] + P) % P) % P;
    }
    writeln(d);
}