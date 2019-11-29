import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto s = readln.chomp.to!(char[]);
    auto n = s.length;
    foreach (i; 0..n/2) {
        auto a = s[i];
        auto b = s[n-1-i];
        if (a == '*' || b == '*' || a == b) continue;
        else {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}