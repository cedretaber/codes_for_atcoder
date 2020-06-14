import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto X = xy[0];
    auto Y = xy[1];
    foreach (i; 0..X+1) {
        auto j = X-i;
        if (i*2 + j*4 == Y) {
            writeln("Yes");
            return;
        }
    }
    writeln("No");
}