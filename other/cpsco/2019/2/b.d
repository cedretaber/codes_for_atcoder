import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int s;
    int[] ms;
    foreach (_; 0..N) {
        auto ca = readln.split;
        if (ca[1].to!int == 0) continue;
        if (ca[0] == "+") {
            s += ca[1].to!int;
        } else if (ca[0] == "*") {
            ms ~= ca[1].to!int;
        }
    }
    foreach (m; ms) s *= m;
    writeln(s);
}