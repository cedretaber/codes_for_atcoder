import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[1000001] MEMO;

void main()
{
    auto s = readln.chomp.to!int;

    int i;
    for (;;) {
        ++i;
        if (MEMO[s]) {
            writeln(i);
            return;
        }
        MEMO[s] = true;
        s = s % 2 == 0 ? s / 2 : s * 3 + 1;
    }
}