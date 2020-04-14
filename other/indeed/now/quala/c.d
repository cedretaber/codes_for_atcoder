import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] ss;
    foreach (_; 0..N) ss ~= readln.chomp.to!int;
    sort!"a > b"(ss);
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto k = readln.chomp.to!int;
        if (k == N) {
            writeln(0);
        } else {
            writeln(ss[k] == 0 ? 0 : ss[k] + 1);
        }
    }
}