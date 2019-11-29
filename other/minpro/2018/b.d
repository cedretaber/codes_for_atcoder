import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    int X, K;
    readf("%d %d", &X, &K);

    auto e = 10 ^^ K;
    auto x = X / e * e;
    while (x <= X) x += e;
    writeln(x);
}