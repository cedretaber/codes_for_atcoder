import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

alias IP = Tuple!(int, "idol", double, "p");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto CS = new IP[][](N, M);
    foreach (i; 0..M) {
        foreach (j; 0..N) {
            auto ip = readln.split.to!(int[]);
            CS[i][j] = IP(ip[0]-1, ip[1]);
        }
    }
}