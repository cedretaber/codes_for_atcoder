import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto S = readln.chomp.to!(dchar[]);
    int d1, d2, last;
    auto t = S[0];
    foreach (int i, e; S) if (e != t) {
        auto d = i - last;
        if (d + d1 > d1 + d2) {
            d2 = d1;
            d1 = d;
        }
        last = i;
        t = e;
    }
    if (d2) {
        auto d = S.length - last;
        if (d + d1 > d1 + d2) {
            d2 = d1;
            d1 = d.to!int;
        }
        writeln(d1 + d2);
    } else {
        writeln(d1 > S.length - d1 ? d1 : S.length - d1);
    }
}