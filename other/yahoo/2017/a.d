import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(dchar[]);
    sort(s);
    auto t = "yahoo".to!(dchar[]);
    sort(t);
    writeln(s == t ? "YES" : "NO");
}