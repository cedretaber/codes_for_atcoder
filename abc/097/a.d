import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ad = readln.split.to!(int[]);
    auto a = ad[0];
    auto b = ad[1];
    auto c = ad[2];
    auto d = ad[3];

    writeln(abs(a-c) <= d || (abs(a-b) <= d && abs(b-c) <= d) ? "Yes" : "No");
}