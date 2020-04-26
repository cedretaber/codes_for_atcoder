import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    int a, b;
    foreach (i, c; S) {
        if ((i%2 == 0 && c == '1') || (i%2 == 1 && c == '0')) ++a;
        if ((i%2 == 0 && c == '0') || (i%2 == 1 && c == '1')) ++b;
    }
    writeln(min(a, b));
}