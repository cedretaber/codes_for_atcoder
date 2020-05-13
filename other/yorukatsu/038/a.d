import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(dchar[]);
    auto T = readln.chomp.to!(dchar[]);
    foreach (i; 0..S.length) {
        S = S[1..$] ~ S[0];
        if (S == T) {
            writeln("Yes");
            return;
        }
    }
    writeln("No");
}