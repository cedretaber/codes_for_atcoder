import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range, std.math;

uint P = 10^^9 + 7;

uint mpow(uint x, uint n, uint ret = 1) {
    if (n == 0) return 1;
    if (n&2)
        return mpow(x, n-1, (ret*x)%P);
    else
        return mpow(x, n/2, (ret^^2)%P);
}

void main()
{
    auto nc = readln.chomp.split(" ").map!(to!uint).array;
    auto n = nc[0];
    auto c = nc[1];

    auto as = readln.chomp.split(" ").map!(to!uint).array;
    auto bs = readln.chomp.split(" ").map!(to!uint).array;

    // 部分点仕様
    if (as != bs) {
        writeln("-1");
        return;
    }

    uint[400][400] memo;
    uint solve(uint i, uint rest) {
        if (memo[i][rest]) return memo[i][rest];

        uint ret;

        if (rest == 0)
            ret = 1;
        else if (i >= n)
            return 0;
        else
            foreach (x; 0..rest+1)
                ret = (ret + (mpow(as[i], x) * solve(i+1, rest - x))%P)%P;

        memo[i][rest] = ret;
        return ret;
    }

    solve(0, c);
    writeln(memo[0][c]);
}