import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool acgt(char c) {
    return c == 'A' || c == 'C' || c == 'G' || c == 'T';
}

void main()
{
    auto S = readln.chomp.to!(char[]);

    int max_l = 0;
    foreach (int i; 0..cast(int)S.length) {
        if (!acgt(S[i])) continue;
        auto j = i;
        while (j < S.length && acgt(S[j])) ++j;
        max_l = max(max_l, j-i);
    }
    writeln(max_l);
}