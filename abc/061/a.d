import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    int a, b, c;
    readf("%d %d %d", &a, &b, &c);
    writeln(c >= a && c <= b ? "Yes" : "No");
}