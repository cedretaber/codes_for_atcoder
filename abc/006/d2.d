import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[] cs, ns;
    foreach (_; 0..N) cs ~= readln.chomp.to!int;

    foreach (c; cs) {
        if (ns.empty || ns[$-1] < c) {
            ns ~= c;
        } else if (ns[0] > c) {
            ns[0] = c;
        } else {
            int l, r = ns.length.to!int-1;
            while (l+1 < r) {
                auto m = (l+r)/2;
                if (ns[m] > c) {
                    r = m;
                } else {
                    l = m;
                }
            }
            ns[r] = c;
        }
    }

    writeln(N - ns.length);
}