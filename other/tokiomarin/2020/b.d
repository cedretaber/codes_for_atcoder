import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto av = readln.split.to!(long[]);
    auto A = av[0];
    auto V = av[1];
    auto bw = readln.split.to!(long[]);
    auto B = bw[0];
    auto W = bw[1];
    auto T = readln.chomp.to!long;

    if (A == B) {
        writeln("YES");
        return;
    }
    writeln(V * T - W * T >= abs(A - B) ? "YES" : "NO");
}