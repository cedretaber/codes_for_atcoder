import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AT = Tuple!(long, "a", long, "t");

void main()
{
    auto N = readln.chomp.to!int;
    auto ats = new AT[](N);
    foreach (i; 0..N) {
        auto at = readln.split.to!(long[]);
        ats[i] = AT(at[0], at[1]);
    }
    sort!"a.a > b.a"(ats);
    long t = ats[0].a;
    if (t < ats[0].t) t = ats[0].t;
    foreach (i; 1..N) {
        t = max(ats[i].t, t + ats[i-1].a - ats[i].a);
    }
    writeln(t + ats[$-1].a);
}