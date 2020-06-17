import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto G = new int[][N];
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    auto P = new bool[](N);
    void walk(int i, ref int[] ps) {
        ps ~= i+1;
        P[i] = true;
        foreach (j; G[i]) if (!P[j]) {
            walk(j, ps);
            break;
        }
    }
    int[] rs;
    walk(0, rs);
    rs = rs[1..$];
    rs.reverse();
    walk(0, rs);
    writeln(rs.length);
    writeln(rs.to!(string[]).join(" "));
}