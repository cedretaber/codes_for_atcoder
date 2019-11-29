import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto ip = readln.chomp.split(" ").map!(pipe!((c => c.to!int), (i => i == 1 ? 14 : i))).array;
    auto a = ip[0];
    auto b = ip[1];

    writeln(
        a > b ? "Alice"
        : a < b ? "Bob"
        : "Draw"
    );
}