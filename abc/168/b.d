import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto K = readln.chomp.to!int;
    auto S = readln.chomp;
    if (S.length <= K) {
        writeln(S);
    } else {
        writeln(S[0..K], "...");
    }
}