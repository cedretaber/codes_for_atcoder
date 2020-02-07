import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto as = new int[](M+1);
    foreach (p; readln.split.to!(int[])) ++as[p];
    foreach (i, a; as) if (a > N/2) {
        writeln(i);
        return;
    }
    writeln("?");
}