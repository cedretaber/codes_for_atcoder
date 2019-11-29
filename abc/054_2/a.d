import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    int tol(string n) {
        auto r = n.to!int;
        if (r == 1) r = 14;
        return r;
    }

    auto ab = readln.split;
    auto a = tol(ab[0]);
    auto b = tol(ab[1]);
    writeln(
        a > b ? "Alice" : a < b ? "Bob" : "Draw"
    );
}