import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(char[]);
    auto t = readln.chomp.to!(char[]);

    int i, j;
    while (i < s.length && j < t.length) {
        if (s[i] == t[j]) {
            ++i;
            ++j;
        } else {
            ++j;
        }
    }
    if (i != s.length || s[0] != t[0]) {
        writeln("No");
        return;
    }
    i = 1;
    while (i < t.length && t[i-1] == t[i]) {
        if (i >= s.length || s[i] != t[i]) {
            writeln("No");
            return;
        }
        ++i;
    }
    writeln("Yes");
}