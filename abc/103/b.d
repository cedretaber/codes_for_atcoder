import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    auto T = readln.chomp.to!(wchar[]);

    foreach (_; 0..101) {
        if (S == T) {
            writeln("Yes");
            return;
        }
        S = [S[$-1]] ~ S[0..$-1];
    }
    writeln("No");
}