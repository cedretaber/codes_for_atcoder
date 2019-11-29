import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    long[] cums;
    int[long] cnt;
    long ret;
    cums.length = N;
    foreach (i, a; AS) {
        if (i == 0) {
            cums[i] = a;
        } else {
            cums[i] = cums[i-1] + a;
        }
        if (cums[i] in cnt) {
            ++cnt[cums[i]];
        } else {
            cnt[cums[i]] = 0;
        }
        if (!cums[i]) ++ret;
    }

    foreach (c; cums) {
        if (c in cnt) {
            ret += cnt[c];
            --cnt[c];
        }
    }

    writeln(ret);
}