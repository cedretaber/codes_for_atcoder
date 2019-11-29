import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    int max_t = int.min;
    foreach (i; 0..N) {
        int max_aa = int.min, max_tt;
        foreach (j; 0..N) {
            if (i == j) continue;
            size_t v, w;
            if (i < j) {
                v = i; w = j;
            } else {
                v = j; w = i;
            }
            int a, t;
            foreach (k, x; as[v..w+1]) {
                if (k%2==0) t += x;
                else a += x;
            }
            if (a > max_aa) {
                max_aa = a;
                max_tt = t;
            }
        }
        if (max_tt > max_t) {
            max_t = max_tt;
        }
    }
    writeln(max_t);
}