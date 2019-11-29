import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    int n, k, x, y;
    readf("%d\n%d\n%d\n%d\n", &n, &k, &x, &y);
    writeln((n > k ? k : n)*x + (n - k < 0 ? 0 : n - k)*y);
}