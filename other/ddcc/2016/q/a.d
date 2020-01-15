import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum S = "DiscoPresentsDiscoveryChannelProgrammingContest2016";

void main()
{
    int i,  W = readln.chomp.to!int;
    while (i < S.length) {
        writeln(S[i..min(i+W, S.length)]);
        i += W;
    }
}