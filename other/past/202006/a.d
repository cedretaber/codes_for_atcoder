import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp;
    auto t = readln.chomp;

    bool same_case = true;
    foreach (i; 0..3) {
        if (s[i] == t[i]) continue;
        if (s[i].toLower == t[i].toLower) {
            same_case = false;
            continue;
        }
        writeln("different");
        return;
    }
    writeln(same_case ? "same" : "case-insensitive");
}