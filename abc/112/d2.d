import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

Tuple!(int, int)[] prime_division(int n)
{
    Tuple!(int, int)[] res;
    foreach (i; 2..10^^6+1) {
        if (n%i == 0) {
            int cnt;
            while (n%i == 0) {
                ++cnt;
                n /= i;
            }
            res ~= tuple(i, cnt);
        }
    }
    if (n != 1) res ~= tuple(n, 1);
    return res;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ps = prime_division(M);
    int[] ds = [1];
    foreach (p; ps) {
        auto len = ds.length;
        foreach (i; 0..p[1]+1) {
            foreach (d; ds[0..len]) {
                ds ~= d * p[0]^^i;
            }
        }
    }
    sort(ds);
    foreach (d; ds) if (d >= N) {
        writeln(M/d);
        return;
    }
}