import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    int[char] memo;
    foreach (c; S) {
        if (c !in memo) memo[c] = 0;
        ++memo[c];
    }
    foreach (k, v; memo) {
        if (v != 2) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}