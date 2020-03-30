import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto T = readln.chomp;
    int[27] ss, ts;
    foreach (i; 0..S.length) {
        int s = S[i] - 'a' + 1;
        int t = T[i] - 'a' + 1;
        if (ts[s] == 0 || ts[s] == t) {
            ts[s] = t;
        } else {
            writeln("No");
            return;
        }
        if (ss[t] == 0 || ss[t] == s) {
            ss[t] = s;
        } else {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}