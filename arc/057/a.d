import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

long N = 2*10L^^12;

void main()
{
    auto ak = readln.split.to!(long[]);
    auto A = ak[0];
    auto K = ak[1];

    if (K == 0) {
        writeln(max(N-A, 0));
    } else {
        auto t = A;
        long i = 0;
        while (t < N) {
            ++i;
            t += 1 + K * t;
        }
        writeln(i);
    }
}