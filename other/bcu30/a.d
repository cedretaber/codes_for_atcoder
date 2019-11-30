import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    long x;
    foreach (a; readln.split.to!(long[])) {
        x += a;
        if (x == N) {
            writeln(x);
            return;
        }
        if (x > N) {
            x = 2*N - x;
        }
    }
    writeln(x);
}