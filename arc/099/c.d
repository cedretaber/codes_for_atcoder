import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    readln;

    int cnt = 1;
    N -= K;
    --K;

    while (N > 0) {
        ++cnt;
        N -= K;
    }

    writeln(cnt);
}