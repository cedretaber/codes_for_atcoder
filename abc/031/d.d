import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto kn = readln.split.to!(int[]);
    auto K = kn[0];
    auto N = kn[1];
    string[] vs, ws;
    foreach (_; 0..N) {
        auto vw = readln.split;
        vs ~= vw[0];
        ws ~= vw[1];
    }

    auto ls = new int[](K+1);
    string[] res;
    bool solve(int i) {
        if (i == K) {
            auto s = new string[](K+1);
            foreach (j; 0..N) {
                int l;
                foreach (k, c; vs[j]) {
                    auto d = c - '0';
                    auto r = l + ls[d];
                    if (ws[j].length < r) return false;
                    auto w = ws[j][l..r];
                    if (s[d].empty) {
                        s[d] = w;
                    } else if (s[d] != w) {
                        return false;
                    }
                    l = r;
                }
                if (ws[j].length != l) return false;
            }
            res = s;
            return true;
        } else {
            foreach (l; 1..4) {
                ls[i+1] = l;
                if (solve(i+1)) return true;
            }
            return false;
        }
    }
    solve(0);
    foreach (i; 0..K) writeln(res[i+1]);
}