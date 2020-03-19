import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto dg = readln.split.to!(long[]);
    auto D = dg[0];
    auto G = dg[1];
    long[] ps, cs;
    foreach (_; 0..D) {
        auto pc = readln.split.to!(long[]);
        ps ~= pc[0];
        cs ~= pc[1];
    }
    long r = long.max;
    foreach (x; 0..(1<<D)) {
        long g, rr;
        foreach (i; 0..D) if (x & (1<<i)) {
            rr += ps[i];
            g += 100*(i+1)*ps[i] + cs[i];
        }
        foreach_reverse (i; 0..D) if (!(x & (1<<i))) {
            foreach (_; 0..ps[i]) {
                if (g >= G) break;
                rr += 1;
                g += 100*(i+1);
            }
        }
        if (g >= G) {
            r = min(r, rr);
        }
    }
    writeln(r);
}