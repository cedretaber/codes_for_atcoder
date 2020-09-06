import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!long;
    long[] AS;
    long a_sum;
    foreach (a; readln.split.to!(long[])) {
        AS ~= a;
        a_sum += a;
    }

    if (N == 1) {
        writeln("YES");
        return;
    }

    auto x = N*(N+1) / 2;
    if (a_sum % x != 0) {
        writeln("NO");
        return;
    }
    auto K = a_sum / x;

    long[] ds;
    foreach (i; 0..N) ds ~= AS[(i+1)%N] - AS[i];
    long k;
    foreach (d; ds) {
        if (d > K || (K-d) % N != 0) {
            writeln("NO");
            return;
        }
        k += (K-d) / N;
    }
    writeln(k == K ? "YES" : "NO");
}

/*

5
6 9 12 10 8

3 3 -2 -2 -2

3 5 7 9 6

1 2 3 4 5

15 15 15 15 15
1 2 3 4 5
2 3 4 5 1
3 4 5 1 2
4 5 1 2 3
5 1 2 3 4

3 4 5 1 2
1 2 3 4 5
1 2 3 4 5
1 2 3 4 5
1 2 3 4 5
1 2 3 4 5

5 10 15 20 25
3 4 5 1 2

8 14 20 21 27

6 6 1 6 -19
*/