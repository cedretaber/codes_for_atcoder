import std.stdio, std.algorithm, std.conv, std.array, std.string;

long PN = 10^^9+7;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);

    long[string] memo;
    long solve(int[] ss, long i, long rest, long max_d) {
        if (i < 0) return rest == 0 ? 1 : 0;
        auto key = (i * 10000 * 10000 + rest * 10000 + max_d).to!string;
        if (key in memo) return memo[key];
        long ret;
        foreach (n; 0..min(max_d, rest)+1) {
            if (rest-n < 0) break;
            auto n_max = i == 0 ? 1000 : ss[i-1] == ss[i] ? n : 1000;
            ret = (ret + solve(ss, i-1, rest-n, n_max)) % PN;
        }
        return memo[key] = ret;
    }

    long ret = solve(AS, N-1, BS.reduce!"a+b", 1000);
    memo.clear;
    writeln((ret * solve(BS, M-1, AS.reduce!"a+b", 1000)) % PN);
}
