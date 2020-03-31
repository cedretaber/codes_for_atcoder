import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    string[] ss;
    foreach (_; 0..N) ss ~= readln.chomp;
    int a;
    foreach (s; ss) {
        if (s == "A") {
            ++a;
        } else if (a > 0) {
            --a;
        } else {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}