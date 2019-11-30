import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nst = readln.split.to!(int[]);
    auto N = nst[0];
    auto S = nst[1];
    auto T = nst[2];

    if (S == T) {
        writeln(0);
        return;
    }

    auto s_min = S*2, s_max = S*2+1, i = 1;
    while (s_max < 2^^N) {
        if (s_min <= T && T <= s_max) {
            writeln(i);
            return;
        }
        s_min = s_min * 2;
        s_max = s_max * 2 + 1;
        ++i;
    }
    writeln(-1);
}