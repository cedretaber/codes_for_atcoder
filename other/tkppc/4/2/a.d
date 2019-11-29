import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto xy = readln.split.to!(int[]);
    auto x = xy[0];
    auto y = xy[1];

    if (x == 0 && y == 0) {
        writeln(0);
        return;
    }
    auto c = y/2;
    writeln(y > 0 && y%2 == 0 && abs(x) <= c && abs(x%2) == abs(c%2) ? c : -1);
}