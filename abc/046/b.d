import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    uint n, k;
    readf("%d %d", &n, &k);

    writeln(k * (k-1)^^(n-1));
}