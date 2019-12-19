import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long PRIM = 998244353;

long[2000] RS, BS;

void main()
{
    long[][] MEMO;
    MEMO.length = 4000;
    foreach (ref line; MEMO) line.length = 4000;
    auto S = readln.chomp.to!(wchar[]);
    auto N = S.length;

    foreach (i, s; S) {
        auto pr = i ? RS[i-1] : 0;
        auto pb = i ? BS[i-1] : 0;
        switch (s) {
            case '0':
                RS[i] = pr + 2;
                break;
            case '1':
                RS[i] = pr + 1;
                BS[i] = pb + 1;
                break;
            case '2':
                BS[i] = pb + 2;
                break;
            default:
        }
    }

    long solve(int i, int r) {
        if (i == N*2) return 1;
        if (MEMO[i][r]) return MEMO[i][r];
        long r1, r2;
        if (RS[min(i, N-1)] - r) r1 = solve(i+1, r+1);
        if (BS[min(i, N-1)] - i + r) r2 = solve(i+1, r);
        return MEMO[i][r] = (r1 + r2) % PRIM;
    }

    writeln(solve(0, 0));
}