import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    if (N > M) swap(N, M);
    if (N == 1) {
        writeln(M == 1 ? 1 : M-2);
    } else if (N == 2) {
        writeln(0);
    } else {
        writeln((N-2) * (M-2));
    }
}