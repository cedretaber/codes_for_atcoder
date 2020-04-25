import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto N = nt[0];
    auto T = nt[1];
    auto ts = new int[](T+1);
    foreach (_; 0..N) {
        auto A = readln.chomp.to!int;
        auto a = A;
        while (a <= T) {
            ts[a] += 1;
            a += A;
        }
    }
    writeln(0.reduce!"a > b ? a : b"(ts));
}