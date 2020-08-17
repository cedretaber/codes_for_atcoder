import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;
    int k = int.max;
    char last;
    foreach (i, c; S) {
        if (c != last) {
            if (i) {
                k = min(k, max(i, N-i).to!int);
            }
            last = c;
        }
    }
    writeln(k == int.max ? N : k);
}