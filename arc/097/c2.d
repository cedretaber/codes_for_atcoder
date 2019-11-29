import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto s = readln.chomp.to!(wchar[]);
    auto K = readln.chomp.to!int;

    wchar[][] ss;
    foreach (int i; 0..s.length.to!int) {
        foreach (j; 1..6) {
            j = min(i + j, s.length);
            ss ~= s[i..j];
        }
    }
    ss = ss.sort.uniq.array;
    writeln(ss[K-1]);
}