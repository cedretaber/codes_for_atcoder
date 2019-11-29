import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto A = readln.chomp.to!int;
    auto S = readln.chomp;
    auto f = A == 0;
    foreach (s; S) {
        switch (s) {
            case '+': ++A; break;
            case '-': --A; break;
            default:
        }
        if (!A) f = true;
    }
    writeln(f ? "Yes" : "No");
}