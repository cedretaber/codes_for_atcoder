import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto N = readln.chomp.to!long;

    foreach (h; 1..3501) {
        foreach (n; 1..3501) {
            auto c = N * h * n;
            auto m = 4 * h * n - N * h - N * n;
            if (m <= 0) continue;
            if (c % m == 0) {
                writefln("%s %s %s", h, n, c / m);
                return;
            }
        }
    }
}