import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    ulong a, b, x;
    readf("%d %d %d", &a, &b, &x);
    writeln(b/x - (a == 0 ? -1 : (a-1)/x));
}