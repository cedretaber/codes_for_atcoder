import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    int a, b, c;
    readf("%d %d %d", &a, &b, &c);

    writeln(a+b==c || a+c==b || b+c==a ? "Yes" : "No");
}