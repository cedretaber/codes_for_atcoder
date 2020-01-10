import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    int c;
    foreach (i; 0..N-2) {
        if (S[i..i+3] == "ABC") ++c;
    }
    writeln(c);
}