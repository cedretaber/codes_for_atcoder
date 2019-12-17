import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto xs = readln.split.to!(long[]);
    auto cs = new long[](N+1);
    foreach (x; xs) cs[0] += x;
    foreach (i; 1..N+1) cs[i] = cs[i-1] - xs[i-1]*2;

    foreach (_; 0..Q) {
        auto t = readln.chomp.to!long;
        if (t <= xs[0]) {
            writeln(cs[0] - t*N);
        } else if (t >= xs[$-1]) {
            writeln(t*N + cs[$-1]);
        } else {
            long i, j = N-1;
            while (i+1 < j) {
                auto m = (i+j)/2;
                if (t < xs[m]) {
                    j = m;
                } else {
                    i = m;
                }
            }
            writeln(cs[j] + t*j - t*(N-j));
        }
    }

}