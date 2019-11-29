import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, core.bitop;

void main()
{
    auto N = readln.chomp.to!int;
    if (N < 3 || popcnt(N) == 1) {
        writeln("No");
        return;
    }
    writeln("Yes");
    writefln("%d %d", 1, 2);
    writefln("%d %d", 2, 3);
    writefln("%d %d", 3, N+1);
    writefln("%d %d", N+1, N+2);
    writefln("%d %d", N+2, N+3);
    for (int i = 4; i+1 <= N; i += 2) {
        writefln("%d %d", N+1, i);
        writefln("%d %d", i, i+1);
        writefln("%d %d", N+1, N+i+1);
        writefln("%d %d", N+i+1, N+i);
    }
    if (N%2 == 0) {
        foreach (i; 2..N) {
            if ((N^i^1) < N && (N^i^1) != i) {
                writefln("%d %d", (i != 2 && i%2 == 0) ? i : N+i, N);
                writefln("%d %d", ((N^i^1)%2 == 0) ? N^i^1 : N+(N^i^1), 2*N);
                break;
            }
        }
    }
}