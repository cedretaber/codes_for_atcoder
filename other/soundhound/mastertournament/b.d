import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    auto w = readln.chomp.to!size_t;
    size_t i;
    while (i < S.length) {
        write(S[i]);
        i += w;
    }
    writeln("");
}