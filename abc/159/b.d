import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto rs = S.dup;
    rs.reverse();
    if (S != rs) {
        writeln("No");
        return;
    }
    auto N = S.length;
    auto s = S[0..(N-1)/2];
    rs = s.dup;
    rs.reverse();
    if (s != rs) {
        writeln("No");
        return;
    }
    s = S[(N+3)/2-1..$];
    rs = s.dup;
    rs.reverse();
    if (s != rs) {
        writeln("No");
        return;
    }

    writeln("Yes");
}