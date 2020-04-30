import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias E = Tuple!(string, "n", long, "c");

void main()
{
    auto ql = readln.split.to!(long[]);
    auto Q = ql[0];
    auto L = ql[1];
    E[] stk;
    long size;
    foreach (_; 0..Q) {
        auto q = readln.chomp;
        if (q == "Top") {
            if (size == 0) {
                writeln("EMPTY");
                return;
            } else {
                writeln(stk[$-1].n);
            }
        } else if (q == "Size") {
            writeln(size);
        } else {
            auto qq = q.split;
            if (qq[0] == "Push") {
                auto N = qq[1].to!long;
                auto M = qq[2];
                if (!stk.empty && stk[$-1].n == M) {
                    stk[$-1].c += N;
                } else {
                    stk ~= E(M, N);
                }
                size += N;
                if (size > L) {
                    writeln("FULL");
                    return;
                }
            } else {
                auto N = qq[1].to!long;
                while (!stk.empty && N > 0) {
                    if (stk[$-1].c > N) {
                        size -= N;
                        stk[$-1].c -= N;
                        N = 0;
                    } else {
                        N -= stk[$-1].c;
                        size -= stk[$-1].c;
                        stk = stk[0..$-1];
                    }
                }
                if (N != 0) {
                    writeln("EMPTY");
                    return;
                }
            }
        }
    }
    writeln("SAFE");
}