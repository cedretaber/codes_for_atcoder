import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    long X, Y;
    readf("%d %d", &X, &Y);
    auto n = X;
    long cnt = 0;
    while (n <= Y) {
        cnt++;
        n *= 2;
    }
    writeln(cnt);
}