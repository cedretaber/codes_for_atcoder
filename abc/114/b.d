import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(wchar[]);

    int r = int.max;
    foreach (i; 0..S.length-2) {
        r = min(r, abs(753 - S[i..i+3].to!int));
    }
    writeln(r);
}