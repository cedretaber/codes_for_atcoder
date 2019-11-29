import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(char[]);
    foreach (ref c; S) {
        auto x = c - 'A';
        x = (x + N) % 26;
        c = ('A' + x).to!char;
    }
    writeln(S);
}