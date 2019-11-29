import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto K = S.length;
    int w;
    foreach (s; S) {
        if (s == 'o') ++w;
    }
    writeln(w+(15-K) >= 8 ? "YES" : "NO");
}