import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto K = readln.chomp.to!int;
    auto k = K % S.length;
    writeln(S[k..$] ~ S[0..k]);
}