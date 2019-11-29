import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto K = readln.chomp.to!long;

    if (S.length == 1) {
        writeln(K/2);
        return;
    }

    long[] ns;
    long cnt;
    char last;
    foreach (c; S) {
        if (cnt && last != c) {
            ns ~= cnt;
            cnt = 0;
        }
        ++cnt;
        last = c;
    }
    ns ~= cnt;

    if (ns.length == 1) {
        writeln(S.length * K / 2);
        return;
    }

    long r;
    foreach (n; ns[1..$-1]) r += n/2 * K;
    if (S[0] == S[$-1]) {
        r += ns[0]/2;
        r += ns[$-1]/2;
        r += (ns[0] + ns[$-1])/2 * (K-1);
    } else {
        r += ns[0]/2 * K;
        r += ns[$-1]/2 * K;
    }
    writeln(r);
}