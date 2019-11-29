import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[26] CS;

void main()
{
    foreach (c; readln.chomp) ++CS[c - 'a'];
    int n;
    foreach (c; CS) if (c) {
        if (n == 0) n = c;
        if (n != c) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}