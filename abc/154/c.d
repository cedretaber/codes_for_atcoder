import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    sort(AS);
    foreach (i; 0..N-1) if (AS[i] == AS[i+1]) {
        writeln("NO");
        return;
    }
    writeln("YES");
}