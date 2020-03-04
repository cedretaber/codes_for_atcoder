import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp;
    auto K = readln.chomp.to!int;

    string[] ss;
    bool[string] memo;
    foreach (i; 0..s.length) {
        foreach (j; i+1..min(i+6, s.length+1)) {
            if (s[i..j] !in memo) {
                ss ~= s[i..j];
                memo[s[i..j]] = true;
            }
        }
    }
    sort(ss);
    writeln(ss[K-1]);
}