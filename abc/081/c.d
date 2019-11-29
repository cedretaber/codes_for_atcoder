import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[20_0001] HS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto K = nk[1];
    auto AS = readln.split.to!(int[]);

    int cnt;
    foreach (a; AS) {
        if (!HS[a]) ++cnt;
        ++HS[a];
    }
    HS[].sort();

    int ret;
    foreach (h; HS) {
        if (!h) continue;
        if (cnt > K) {
            ret += h;
            --cnt;
        }
    }
    writeln(ret);
}