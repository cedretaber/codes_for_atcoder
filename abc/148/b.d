import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto st = readln.split.to!(char[][]);
    char[] u;
    foreach (i; 0..N) {
        u ~= st[0][i];
        u ~= st[1][i];
    }
    writeln(u);
}