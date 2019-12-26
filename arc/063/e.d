import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[][] T;
    T.length = N;
    foreach (_; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    auto K = readln.chomp.to!int;
    auto CS = new int[](N);
    auto BS = new int[](N);
    int root;
    bool has_root;
    foreach (_; 0..K) {
        auto vp = readln.split.to!(int[]);
        auto v = vp[0]-1;
        if (!has_root) {
            root = v;
        }
        BS[v] = 1;
        CS[v] = vp[1];
    }

    auto RS = new int[](N);
    int[] ROOTS;
    void tmp_paint(int i, int p, int r) {
        if (BS[i] == 0) {
            BS[i] = 2;
            CS[i] = CS[p];
        }
        RS[i] = r;
        bool is_root = true;
        foreach (j; T[i]) if (j != p) {
            tmp_paint(j, i, r+1);
            is_root = false;
        }
        if (is_root) {
            ROOTS ~= i;
        }
    }
    tmp_paint(root, -1, 0);

    bool paint(int i, int p) {
        if (p != -1) {
            if (BS[i] == 2) {
                if (CS[i]+1 != CS[p] && CS[i]-1 == CS[p]) {
                    if (CS[i] < CS[p]) {
                        CS[i] = CS[p] - 1;
                    } else {
                        CS[i] = CS[p] + 1;
                    }
                } else {
                    return true;
                }
            } else {
                if (CS[i]+1 != CS[p] && CS[i]-1 == CS[p]) return false;
            }
        }
        foreach (j; T[i]) if (RS[j] > RS[i]) {
            return paint(j, i);
        }
        return true;
    }

    foreach (r; ROOTS) {
        if (!paint(r, -1)) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
    writeln(CS[].to!(string[]).join("\n"));
}