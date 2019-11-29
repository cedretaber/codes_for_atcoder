import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto ip = readln.split.to!(int[]);
    auto A = ip[0];
    auto B = ip[1];
    auto C = ip[2];
    auto X = ip[3];
    auto Y = ip[4];

    writeln(min(
        X * A + Y * B,
        X * 2 * C + max(Y - X, 0) * B,
        max(X - Y, 0) * A + Y * C * 2,
        max(X, Y) * C * 2
    ));
}