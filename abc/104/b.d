import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    if (S[0] != 'A') {
        writeln("WA");
        return;
    }
    auto len = S.length;
    int C;
    foreach (i, c; S) {
        if (!i) continue;
        if (i >= 2 && i <= len - 2 && c == 'C') {
            ++C;
        } else if (c >= 'A' && c <= 'Z') {
            writeln("WA");
            return;
        }
    }
    if (C != 1) {
        writeln("WA");
        return;
    }
    writeln("AC");
}