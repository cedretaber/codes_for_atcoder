import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto na = readln.split.to!(int[]);
    auto N = na[0];
    auto a = na[1]-1;
    auto K = readln.chomp;
    auto bs = readln.split.map!(b => b.to!int-1).array;

    auto ii = new int[](N);
    int[] nn;
    ii[] = -1;
    int i = a, c = 0, r;
    while (i != -1) {
        if (ii[i] == -1) {
            ii[i] = c++;
            nn ~= bs[i]+1;
            i = bs[i];
        } else {
            r = i;
            i = -1;
        }
    }

    long k;
    if (K.length <= 18) {
        k = K.to!long-1;
        if (k < c) {
            writeln(nn[k]);
            return;
        }
        nn = nn[ii[r]..$];
        auto len = nn.length;
        k = (k - ii[r]) % len;
    } else {
        nn = nn[ii[r]..$];
        auto len = nn.length;
        k = ((BigInt(K) - ii[r] - 1) % len).to!int;
    }
    writeln(nn[k]);
}