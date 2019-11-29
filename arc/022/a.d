import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp.to!(char[]);
    int i;
    foreach (c; S) {
        if (i == 0 && (c == 'i' || c == 'I')) {
            ++i;
        } else if (i == 1 && (c == 'c' || c == 'C')) {
            ++i;
        } else if (i == 2 && (c == 't' || c == 'T')) {
            writeln("YES");
            return;
        }
    }
    writeln("NO");
}