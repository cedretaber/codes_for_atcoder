import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto hs = readln.split.to!(int[]);
    auto X = readln.chomp.to!int;

    foreach (i, h; hs) if (h > X) {
        writeln(i+1);
        return;
    }
    writeln(N+1);
}