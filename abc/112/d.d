import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto min_i = 1, max_i = M;
    auto mid_i = (min_i + max_i) / 2;
    while (max_i - min_i > 1) {
        mid_i = (min_i + max_i) / 2;
        if (M / mid_i < N) {
            max_i = mid_i;
        } else {
            min_i = mid_i;
        }
    }
    mid_i += 1000;
    for (;;) {
        if (M % mid_i == 0 && M / mid_i >= N ) {
            writeln(mid_i);
            break;
        }
        --mid_i;
    }
}