import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    readln;
    int[long] MEMO;
    foreach (a; readln.split.to!(long[])) {
        while (a%2 == 0) a /= 2;
        MEMO[a] = 1;
    }
    int r;
    foreach (_; MEMO) ++r;
    writeln(r);
}