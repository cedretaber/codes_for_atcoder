import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[9] COLOURS;

void main()
{
    readln;
    auto as = readln.split.to!(int[]);

    foreach (a; as) {
        auto idx = a / 400;
        if (idx > 8) idx = 8;
        COLOURS[idx] += 1;
    }

    auto min = COLOURS[0..8].count!"a != 0";
    auto max = min + COLOURS[8];
    if (min == 0) min = 1;

    writefln("%d %d", min, max);
}