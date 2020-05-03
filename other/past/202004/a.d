import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto st = readln.split;
    int a, b;
    if (st[0][0] == 'B') {
        a = -(st[0][1] - '0').to!int;
    } else {
        a = st[0][0] - '0';
    }
    if (st[1][0] == 'B') {
        b = -(st[1][1] - '0').to!int;
    } else {
        b = st[1][0].to!int - '0';
    }
    auto r = abs(a - b);
    if (a*b < 0) r -= 1;
    writeln(r);
}