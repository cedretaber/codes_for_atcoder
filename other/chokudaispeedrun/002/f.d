import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    bool[long] MEMO;
    foreach (_; 0..N) {
        auto wh = readln.split.to!(long[]);
        auto x = (min(wh[0], wh[1]) - 1) * 10L^^10;
        auto y = (max(wh[0], wh[1]) - 1);
        MEMO[x + y] = true;
    }
    int s;
    foreach (_; MEMO) ++s;
    writeln(s);
}