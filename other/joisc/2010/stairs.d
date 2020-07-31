import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

enum M = 1234567;

void main()
{
    auto np = readln.split.to!(int[]);
    auto N = np[0];
    auto P = np[1];
    int[] hs = [0];
    foreach (i; 0..N) hs ~= readln.chomp.to!int + hs[i];

    auto DP = new int[](N+1);
    DP[0] = 1;
    foreach (i; 0..N) {
        if (hs[i+1] - hs[i] > P) {
            writeln(0);
            return;
        }
        (DP[i+1] += DP[i]) %= M;
        if (hs[N] - hs[i] > P) {
            int l = i+1, r = N;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (hs[m] - hs[i] <= P) {
                    l = m;
                } else {
                    r = m;
                }
            }
            (DP[r] += M - DP[i]) %= M;
        }
        if (i) (DP[i+1] += DP[i]) %= M;
    }
    writeln(DP[N]);
}


/*

6 350
315
191
98
70
126
200

0 1  2  3  4  5  6
_ 1 -1              1 0
  _  1  0 -1        1 1
     _  1  0  0 -1  1 2
        _  2  0 -2  2 3
           _  3  0  3 4
              _  6  6 5
                    9 6
                  

*/