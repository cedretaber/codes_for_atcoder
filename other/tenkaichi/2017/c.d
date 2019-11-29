import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto N = readln.chomp.to!long;
    auto n = 0;
    for (;;) {
        ++n;
        if ((N * n % (3 * n - N)) == 0 && (N * n / (3 * n - N)) > 0) break;
    }
    writefln("%s %s %s", N, n, (N * n / (3 * n - N)));
}