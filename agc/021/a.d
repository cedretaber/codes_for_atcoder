import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp;
    int l = N.length.to!int;
    int r, p;
    foreach (int i, c; N) {
        auto n = c-48;
        if (n) {
            r = max(r, p + n-1 + (l-i-1)*9);
            p += n;
        }
    }
    writeln(max(r, p));
}