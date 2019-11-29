import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;
 
alias M = Tuple!(int, "a", int, "b", int, "c");
 
void main()
{
    immutable nm = readln.chomp.split(" ").map!(to!int).array;
    immutable n = nm[0];
    immutable ma = nm[1];
    immutable mb = nm[2];
 
    auto meds = new M[n];
    foreach(ref m; meds) {
        auto abc = readln.chomp.split(" ").map!(to!int).array;
        m = M(abc[0], abc[1], abc[2]);
    }
 
    auto memo = new int[500][500][41];
    int buy(int a, int b, size_t idx)
    {
        if (memo[idx][a][b])
            return memo[idx][a][b];

        if (idx >= n) {
            immutable div = gcd(a, b);
            if (div) {
                a /= div;
                b /= div;
            }
            return memo[idx][a][b] = ma == a && mb == b ? 1 : int.max;
        }

        auto head = meds[idx];

        auto a_ = a + head.a;
        auto b_ = b + head.b;
 
        auto ret1 = buy(a, b, idx+1);
        auto ret2 = buy(a_, b_, idx+1);
        ret2 = ret2 == int.max ? ret2 : ret2 + head.c;

        return memo[idx][a][b] = min(ret1,  ret2);
    }
 
    immutable min_c = buy(0, 0, 0);
    writeln(min_c == int.max ? -1 : min_c -1);
}