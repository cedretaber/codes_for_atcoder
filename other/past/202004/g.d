import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias CS = Tuple!(char, "c", long, "n");

void main()
{
    auto Q = readln.chomp.to!int;
    CS[] S;
    foreach (_; 0..Q) {
        auto q = readln.split;
        if (q[0] == "1") {
            auto c = q[1][0];
            auto x = q[2].to!long;
            S ~= CS(c, x);
        } else {
            auto d = q[1].to!long;
            long[26] count;
            while (d != 0 && !S.empty) {
                auto h = S[0];
                if (S[0].n > d) {
                    S[0].n -= d;
                    count[h.c - 'a'] += d;
                    d = 0;
                } else {
                    S = S[1..$];
                    count[h.c - 'a'] += h.n;
                    d -= h.n;
                }
            }
            long r;
            foreach (c; count) r += c^^2;
            writeln(r);
        }
    }
}