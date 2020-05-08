import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;

    int[26] cs, ds;
    foreach (i; 0..S.length) {
        auto s = S[i] - 'a';
        auto t = T[i] - 'a';
        if (cs[s] == 0 && ds[t] == 0) {
            cs[s] = t+1;
            ds[t] = s+1;
        } else if (cs[s] != t+1 || ds[t] != s+1) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}