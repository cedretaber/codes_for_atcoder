import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    int[char] t;
    foreach (c; S) t[c] += 1;
    char x;
    int p;
    foreach (c, n; t) if (n > p) {
        x = c;
        p = n;
    }
    writeln(x);
}