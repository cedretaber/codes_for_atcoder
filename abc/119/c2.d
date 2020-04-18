import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ns = readln.split.to!(int[]);
    auto N = ns[0];
    auto A = ns[1];
    auto B = ns[2];
    auto C = ns[3];
    int[] ls;
    foreach (_; 0..N) ls ~= readln.chomp.to!int;

    auto as = new int[](N);
    int solve(int i) {
        if (i == N) {
            int a, b, c, an, bn, cn;
            foreach (j; 0..N) {
                switch (as[j]) {
                    case 1: a += ls[j]; ++an; break;
                    case 2: b += ls[j]; ++bn; break;
                    case 3: c += ls[j]; ++cn; break;
                    default:
                }
            }
            if (an == 0 || bn == 0 || cn == 0) return int.max;
            return abs(A - a) + abs(B - b) + abs(C - c) + (an-1)*10 + (bn-1)*10 + (cn-1)*10;
        } else {
            int r = int.max;
            foreach (j; 0..4) {
                as[i] = j;
                r = min(r, solve(i+1));
            }
            return r;
        }
    }
    writeln(solve(0));
}