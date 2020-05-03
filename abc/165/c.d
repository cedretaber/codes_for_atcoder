import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];

    int[] as, bs, cs;
    long[] ds;
    foreach (_; 0..Q) {
        auto abcd = readln.split.to!(int[]);
        as ~= abcd[0]-1;
        bs ~= abcd[1]-1;
        cs ~= abcd[2];
        ds ~= abcd[3];
    }

    auto ns = new int[](N);
    long solve(int i, int p) {
        long r;
        if (i == N) {
            foreach (k; 0..Q) {
                if (ns[bs[k]] - ns[as[k]] == cs[k]) r += ds[k];
            }
            return r;
        } else {
            foreach (j; p..M+1) {
                ns[i] = j;
                r = max(r, solve(i+1, j));
            }
            return r;
        }
    }
    writeln(solve(0, 1));
}