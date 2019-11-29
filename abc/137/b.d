import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kx = readln.split.to!(int[]);
    auto K = kx[0];
    auto X = kx[1];
    auto i = X-K+1;
    int[] r;
    while (i < X+K) {
        r ~= i++;
    }
    writeln(r.to!(string[]).join(" "));
}