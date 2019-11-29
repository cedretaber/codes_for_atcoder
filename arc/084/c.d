import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!size_t;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);
    auto CS = readln.split.to!(long[]);

    sort(AS);
    sort(BS);
    sort(CS);

    long[] bmemo;
    bmemo.length = N;
    size_t i;
    foreach (j, b; BS) {
        for (; i < N; ++i) if (AS[i] >= b) break;
        bmemo[j] = i + (j == 0 ? 0 : bmemo[j-1]);
    }

    i = 0;
    long ret;
    foreach (c; CS) {
        for (; i < N; ++i) if (BS[i] >= c) break;
        ret += i == 0 ? 0 :  bmemo[i-1];
    }

    writeln(ret);
}