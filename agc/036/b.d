import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0].to!int;
    auto K = nk[1];
    auto AS = readln.split.to!(int[]);

    if (N == 1) {
        writeln(K%2 == 0 ? "" : AS[0].to!string);
        return;
    }

    auto FS = new int[](2*10^^5+1);
    FS[] = -1;
    auto LS = new int[](2*10^^5+1);
    LS[] = -1;
    auto NS = new int[](N);
    NS[] = -1;

    foreach (i; 0..N) if (FS[AS[i]] == -1) FS[AS[i]] = i;
    foreach_reverse (i; 0..N) {
        if (LS[AS[i]] != -1) NS[i] = LS[AS[i]];
        LS[AS[i]] = i;
    }

    auto memo = [0];
    int k = 1;
    int i;
    if (NS[0] == -1) {
        i = 1;
        ++k;
        memo ~= i;
    } else {
        i = NS[0] + 1;
    }
    while (i != N) {
        if (NS[i] == -1) {
            i = FS[AS[i]] + 1;
            ++k;
            memo ~= i;
        } else {
            i = NS[i] + 1;
        }
    }

    if (k == 1) {
        writeln("");
        return;
    }

    i = memo[K%k-1];
    int[] rr;
    while (i < N) {
        if (NS[i] == -1) {
            rr ~= AS[i];
        } else {
            i = NS[i];
        }
        ++i;
    }
    writeln(rr.to!(string[]).join(" "));
}