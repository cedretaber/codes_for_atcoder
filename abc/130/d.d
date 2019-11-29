import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] AS;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    foreach (i, a; readln.split.to!(long[])) AS[i] = a;

    long r;
    auto A = AS[0];
    long i, j = 1;
    for (;;) {
        if (A >= K) {
            r += N-j+1;
            A -= AS[i++];
        } else if (j < N) {
            A += AS[j++];
        } else {
            break;
        }
    }
    writeln(r);
}