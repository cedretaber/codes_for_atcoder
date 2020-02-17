import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias CSF = Tuple!(long, "c", long, "s", long, "f");

void main()
{
    auto N = readln.chomp.to!int;
    CSF[] ss;
    foreach (_; 0..N-1) {
        auto csf = readln.split.to!(long[]);
        ss ~= CSF(csf[0], csf[1], csf[2]);
    }
    long[] rs;
    foreach (i; 0..N-1) {
        long s;
        foreach (j; i..N-1) {
            s = max(s, ss[j].s);
            s += ss[j].c + ((s%ss[j].f == 0) ? 0 : (ss[j].f - s%ss[j].f));
        }
        rs ~= s;
    }
    rs ~= 0;
    foreach (r; rs) writeln(r);
}