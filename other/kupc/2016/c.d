import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto DP = new int[](128, 1000);
    foreach (i; 0..1000) {
        foreach (b; 0..128) {
            if (i == 0) {
                DP[b][i] = b;
            } else {
                foreach (c; 0..128) {
                    DP[b][i] = max(DP[])
                }
            }
        }
    }
    auto T = readln.chomp.to!int;
}