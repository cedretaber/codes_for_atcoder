import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto PS = readln.split.to!(int[]).map!"a-1"().array();
    auto CS = readln.split.to!(long[]);

    long max_c = long.min;
    foreach (i; 0..N) {
        auto hs = new int[](N);
        auto cs = new long[](N+2);
        int p = PS[i];
        long c = CS[p];
        max_c = max(max_c, c);
        hs[p] = 1;
        cs[1] = c;
        foreach (j; 2..K+1) {
            p = PS[p];
            c += CS[p];
            cs[j] = c;
            max_c = max(max_c, c);
            if (hs[p] != 0) {
                long n = j - hs[p];
                long d = c - cs[hs[p]];
                if (d < 0) goto end;
                long l = (K-hs[p]) / n;
                long r = (K-hs[p]) % n;
                c = cs[hs[p]] + d * l;
                max_c = max(max_c, c);
                foreach (_; 0..r) {
                    p = PS[p];
                    c += CS[p];
                    max_c = max(max_c, c);
                }
                goto end;
            }
            hs[p] = j;
        }
        end:
    }
    writeln(max_c);
}

/*

1 2 3 1
1 2 3 4 => 4-1 = 3


1 2 3
1 3 6 7

1 2 3 4

29507023469
29507023469
3928058396
3928058396
1163268806

9 1 6 7 8 4 3 2 10 5

1 -> 9 -> 10 -> 5 -> 8 -> 2 -> 1
3 -> 6 -> 4 -> 7 -> 3

*/