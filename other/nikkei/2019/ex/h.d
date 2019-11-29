import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;
    if (N < 8) {
        writeln(N%2 == 1 ? "Win" : "Lose");
        return;
    }
    N -= 8;
    writeln( ((N/9)%2 == 0 && N%2 == 0) || ((N/9)%2 == 1 && N%2 == 1) ? "Win" : "Lose" );
}