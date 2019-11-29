import std.stdio, std.algorithm, std.conv, std.array, std.range, std.string, std.math, std.typecons;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];

    long ret;
    if (N == 1 && M == 1) {
        ret = 1;
    } else if (N == 1) {
        ret = M - 2;
    } else if (M == 1) {
        ret = N - 2;
    } else if (N == 2 || M == 2) {
        ret = 0;
    } else {
        ret = N * M - N * 2 - M * 2 + 4;
    }
    writeln(ret);
}